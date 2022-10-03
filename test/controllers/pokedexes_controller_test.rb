require "test_helper"

class PokedexesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pokedexes_index_url
    assert_response :success
  end
end
