class Public::TaskCommentsController < ApplicationController
  def create
    @task = Task.find_by(params[:task_id])
    @comment = current_customer.task_comments.new(comment_params)
    @comment.task_id = @task.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :tasks_comments  #render先にjsファイルを指定
    else
      render 'tasks/show'
    end
  end


  def destroy
    TaskComment.find(params[:id]).destroy
    @task = Task.find(params[:task_id])
    render :task_comments
  end

   private

  def comment_params
    params.require(:task_comment).permit(:comment)
  end
end


