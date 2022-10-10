require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
        @admin = admins(:admin1)
        @report = reports(:one)
      end 

      test 'admins has his own home page' do
        sign_in @admin
        get root_path
        assert_select 'div.container'
        assert_select 'h1', "Welcome to Reporting App"
        assert_select 'a[href=?]',reports_path, text: "Get started"
        assert_select 'a[href=?]',reports_path, text: "Reports"
        assert_select 'a[href=?]',root_path, text: "Home"
        assert_select 'a[href=?]',placements_path, text: "Placements"
        assert_select 'a[href=?]',edit_admin_registration_path, text: "Settings"
      end

      test 'visitors home page' do
        get root_path
        assert_select 'div.container'
        assert_select 'h1', "Welcome to ReportingApp."
        assert_select 'a[href=?]',new_admin_session_path, text: "I am an admin"
        assert_select 'a[href=?]',new_admin_session_path , text: "Log in"
        assert_select 'a[href=?]',root_path, text: "Home"

      end


    end