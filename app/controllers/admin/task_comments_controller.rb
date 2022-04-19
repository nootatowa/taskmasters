class Admin::TaskCommentsController < ApplicationController
  def index
    @task_comments = TaskComment.all
    @customers = Customer.all
  end

  def destroy
    TaskComment.find_by(params[:id]).destroy
    render "index"
  end

  private

  def task_comment_params
    params.require(:task_comment).permit(:comment)
  end

end
