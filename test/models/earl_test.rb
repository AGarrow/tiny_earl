require 'test_helper'

class EarlTest < ActiveSupport::TestCase
  describe '#create' do
    it 'should create an Earland assign it a valid short url' do
      earl = Earl.create(full_url: 'https://reddit.com')
      assert earl.short_url
    end
  end
end
