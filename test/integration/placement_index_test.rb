require "test_helper"

class PlacementIndexTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
        @admin = admins(:admin1)
        @report = reports(:one)
      end 

      test 'admins can see reports page' do
        sign_in @admin
        get placements_path
        assert_select 'div.container'
        assert_select 'a[href=?]',retrieve_path, text: "Retrieve placements"
        assert_select 'table', true
        assert_select 'form', true
      end
    end