class Public::TaskCommentsController < ApplicationController
  
  def create
    @task = Task.find(params[:task_id])
    @comment = current_customer.task_comments.new(comment_params)
    @comment.task_id = @task.id
    @comment.save
     flash.now[:notice] = 'コメントを投稿しました'
  end


  def destroy
    TaskComment.find(params[:id]).destroy
    flash.now[:alert] = 'コメントを削除しました'
    @task = Task.find(params[:task_id])
  end

   private

  def comment_params
    params.require(:task_comment).permit(:comment)
  end

end