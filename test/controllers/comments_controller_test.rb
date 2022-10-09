require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @admin = admins(:admin1)
    @report = reports(:one)
    @comment = comments(:comment1)
  end 
 
  test "should redirect create when not admin" do 
    assert_no_difference 'Comment.count' do
      post report_comments_path(@report, @comment), params: { comment: {content: @comment.content} }
    end
    assert_redirected_to root_path
  end

  test "should create comment as admin" do 
      sign_in @admin
      assert_difference('Comment.count') do
        post report_comments_path(@report, @comment), params: { comment: {content: @comment.content} }
      end
      assert_redirected_to report_path(@report)
      
    end

  test "visitors should not get new" do
   get new_report_comment_path(@report)
   assert_redirected_to root_path
  end

  test "admins should get new" do
    get new_report_comment_path(@report)
    assert :success
   end
end