require 'test_helper'

class EarlCreationTest < TinyEarl::IntegrationTest
  describe 'earl creation' do
    let(:new_full_url) { 'https://nytimes.com' }
    it 'should create a short url, render it in the view as a link' do
      visit '/'
      page.assert_selector 'input#earl_full_url'
      fill_in 'earl[full_url]', with: new_full_url
      click_button 'Go'
      page.assert_selector 'a#short-url'
      page.assert_selector 'button#copy'
    end

    it 'should alert the user of an invalid url' do
      visit '/'
      fill_in 'earl[full_url]', with: 'invalid'
      click_button 'Go'
      page.assert_selector 'div.alert.alert-warning'
      page.body.include? I18n.t('activerecord.errors.models.earl.attributes.full_url.invalid')
    end
  end
end
