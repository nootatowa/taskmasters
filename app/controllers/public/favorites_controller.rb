class Public::FavoritesController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    favorite = current_customer.favorites.new(task_id: @task.id)
    favorite.save
    @likes_customer = current_customer
    @likes_customer.update(experience_point: @likes_customer.experience_point + 2)
    result = LevelSetting.where("threshold <= ?", @likes_customer.experience_point)
    if result.any?
    if  @likes_customer.level !=  result.last.level
        @likes_customer.level =  result.last.level
        @likes_customer.save
    end
    end
  end
  def destroy
    @task = Task.find(params[:task_id])
    favorite = current_customer.favorites.find_by(task_id: @task.id)
    favorite.destroy
  end



  private
  def task_params
    @task = Task.find(params[:task_id])
  end

end
