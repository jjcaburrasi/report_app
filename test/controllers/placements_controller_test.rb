require "test_helper"

class PlacementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = admins(:admin1)
    @placement = placements(:placement1)
  end

  test "should get placements index as admin" do
    sign_in @admin
    get placements_path
    assert_response :success
  end

  test "should not get placements index as visitor" do
    get placements_path
    assert_redirected_to root_path
  end

  test "visitor should not get export" do
    get export_placements_path
    assert_redirected_to root_path
  end


end