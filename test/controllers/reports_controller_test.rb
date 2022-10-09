require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    admin = admins(:admin1)
  end 


  test "visitor should not get index" do
    get reports_path
    assert redirect_to root_path
  end
end
