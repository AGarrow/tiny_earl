require 'test_helper'

class InfiniteScrollTest < TinyEarl::IntegrationTest
	describe 'infinite scroll' do
		before do
			1.upto(90) do |i|
				Earl.create(
					full_url: "https://example.com/#{i}"
				)
			end
		end

		it 'should render continue loading more until there are no more earls' do
			visit "/"
			page.assert_selector(".list-group-item", count: 25)
			click_button(I18n.t('components.buttons.load_more'))
			wait_for_ajax
			page.assert_selector(".list-group-item", count: 50)
			click_button(I18n.t('components.buttons.load_more'))
			page.assert_selector(".list-group-item", count: 75)
			click_button(I18n.t('components.buttons.load_more'))
			page.assert_selector(".list-group-item", count: Earl.all.count)
			page.assert_text(I18n.t('messages.nothing_else_here'))			
		end
	end
end