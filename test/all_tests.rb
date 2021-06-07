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
  end
end
