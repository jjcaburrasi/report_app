require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @admin = admins(:admin1)
    @report = reports(:one)
  end 

  test "visitor should not get index" do
    get reports_path
    assert_redirected_to root_path
  end

  test "admin should get index" do
    sign_in @admin
    get reports_path
    assert :success
  end

  test "visitor should not get show" do
    get report_path(@report)
    assert_redirected_to root_path
  end

  test "admin should get show" do
    sign_in @admin
    get report_path(@report)
    assert :success
  end

  test "visitor should not get export" do
    get export_path(@report)
    assert_redirected_to root_path
  end

  test "admin should get export" do
    sign_in @admin
    get export_path
    assert :success
  end

end
