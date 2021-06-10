require 'test_helper'
class Banknote::AssetTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    Rails.application
  end

  # it is in progress now :)

  test 'GET /api/v1/banknote_asset' do
    get('/api/v1/banknote_asset')
    assert last_response.ok?
    assert_equal 200, last_response.status
  end

  test 'Successful cash withdrawal' do
    patch('/api/v1/banknote_asset?sum=93')
    assert_equal '[1, 2, 5, 10, 25, 50]', last_response.body
  end

  test 'Unable to issue required amount' do
    patch('/api/v1/banknote_asset?sum=94')
    assert_equal 'transaction not allowed', last_response.body
  end
end
