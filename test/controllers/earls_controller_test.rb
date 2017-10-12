require 'test_helper'

class EarlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @earl = earls(:one)
  end

  test "should get index" do
    get earls_url
    assert_response :success
  end

  test "should get new" do
    get new_earl_url
    assert_response :success
  end

  test "should create earl" do
    assert_difference('Earl.count') do
      post earls_url, params: { earl: { full_url: @earl.full_url, short_url: @earl.short_url, view_count: @earl.view_count } }
    end

    assert_redirected_to earl_url(Earl.last)
  end

  test "should show earl" do
    get earl_url(@earl)
    assert_response :success
  end

  test "should get edit" do
    get edit_earl_url(@earl)
    assert_response :success
  end

  test "should update earl" do
    patch earl_url(@earl), params: { earl: { full_url: @earl.full_url, short_url: @earl.short_url, view_count: @earl.view_count } }
    assert_redirected_to earl_url(@earl)
  end

  test "should destroy earl" do
    assert_difference('Earl.count', -1) do
      delete earl_url(@earl)
    end

    assert_redirected_to earls_url
  end
end
