class Public::FavoritesController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    favorite = current_customer.favorites.new(task_id: @task.id)
    favorite.save
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find(params[:task_id])
    favorite = current_customer.favorites.find_by(task_id: @task.id)
    favorite.destroy
    redirect_to task_path(@task)
  end



  private
  def task_params
    @task = Task.find(params[:task_id])
  end

end
