class Public::FavoritesController < ApplicationController
  before_action :set_favorite, only: %i(create destroy)

  def create
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
    favorite = current_customer.favorites.find_by(task_id: @task.id)
    favorite.destroy
  end



  private
  def task_params
    @task = Task.find(params[:task_id])
  end

  def set_favorite
    @task = Task.find(params[:task_id])
  end

end
