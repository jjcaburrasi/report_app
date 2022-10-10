require "test_helper"

class ReportIndexTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
        @admin = admins(:admin1)
        @report = reports(:one)
      end 

    test 'admins can see reports page' do
        sign_in @admin
        get reports_path
        assert_select 'div.container'
        assert_select 'h2', "Reports"
        assert_select 'a[href=?]',sync_path, text: "Retrieve reports"
        assert_select 'a[href=?]',reports_path, text: "Undo Filters"
        assert_select 'form', true
      end


end