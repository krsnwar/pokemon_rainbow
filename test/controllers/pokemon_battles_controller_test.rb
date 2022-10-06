require "test_helper"

class PokemonBattlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pokemon_battles_index_url
    assert_response :success
  end
end
