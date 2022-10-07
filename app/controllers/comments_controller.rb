class CommentsController < ApplicationController
    def new
        @report = Report.find(params[:report_id])
        @comment = Comment.new
    end
    
    def create
        @report = Report.find(params[:report_id])
        @admin = current_admin
        @comment = Comment.new(comment_params)
        @comment.admin = @admin
        @comment.report = @report
        if @comment.save 
            flash[:success] = 'Comment created'
            redirect_to @report
        else
            redirect_to @report
        end
    end


    private
        def comment_params
            params.require(:comment).permit(:content, :admin_id, :report_id)
        end
end