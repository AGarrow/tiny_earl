require 'test_helper'

class EarlsControllerTest < ActionDispatch::IntegrationTest
  let(:youtube) { earls(:youtube) }

  describe '#index' do
    it 'should get index' do
      get earls_url
      assert_response :success
    end

    it 'responds to js' do
      get earls_url(format: :js), xhr: true
      assert_response :success
    end

    it 'responds to page params for js requests' do
      get earls_url(page: 1, format: :js), xhr: true
      refute response.body.include?(I18n.t('messages.nothing_else_here'))
      get earls_url(page: 2, format: :js), xhr: true
      assert response.body.include?(I18n.t('messages.nothing_else_here'))
    end
  end

  describe '#create' do
    it 'should create earl and return a short_url' do
      assert_difference('Earl.count') do
        post earls_url, params: { earl: { full_url: 'https://facebook.com' } }
      end

      assert_response :success
      json = JSON.parse(response.body)
      refute_nil json['short_url']
    end

    it 'should return an existing earl if existing full_url is passed' do
      assert_difference('Earl.count', 0) do
        post earls_url, params: { earl: { full_url: youtube.full_url } }
      end
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal earl_url(youtube), json['short_url']
    end

    it 'should return a json with errors if an invalid URL is submitted' do
      post earls_url, params: { earl: { full_url: 'this_aint_no_earl' } }
      assert_response 422
      refute_nil JSON.parse(response.body)['full_url']
    end
  end

  describe '#show' do
    it 'should redirect to the urls full path' do
      get earl_url(youtube)
      assert_redirected_to youtube.full_url
    end

    it 'should increment the urls view count' do
      assert_difference('youtube.reload.view_count', 1) do
        get earl_url(youtube)
      end
    end

    it 'should render a 404 for an invalid short url' do
      assert_raises(ActionController::RoutingError) do
        get earl_url(short_url: 'invalid_string')
      end
    end
  end
end
