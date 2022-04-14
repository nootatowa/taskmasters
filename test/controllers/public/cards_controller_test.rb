require "test_helper"

class Public::CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_cards_new_url
    assert_response :success
  end

  test "should get create" do
    get public_cards_create_url
    assert_response :success
  end
end
