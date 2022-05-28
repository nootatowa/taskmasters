class Public::TaskCommentsController < ApplicationController
  before_action :set_task_comment, only: %i(create destroy)

  def create
    @comment = current_customer.task_comments.new(comment_params)
    @comment.task_id = @task.id
    @comment.save
     flash.now[:notice] = 'コメントを投稿しました'
  end


  def destroy
    current_customer.task_comments.find(params[:id]).destroy
     flash.now[:alert] = 'コメントを削除しました'
  end

 private

  def comment_params
    params.require(:task_comment).permit(:comment)
  end

  def set_task_comment
    @task = Task.find(params[:task_id])
  end

end