class Public::FavoritesController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    favorite = current_customer.favorites.new(task_id: @task.id)
    favorite.save
    # @liked_customer = @task.customer
    # @likes_customer = current_customer
    # @liked_customer.update(experience_point: @liked_customer.experience_point + 2)
    # @likes_customer.update(experience_point: @likes_customer.experience_point + 2)
    # @new_level = LevelSetting.where(threshold:  @likes_customer.experience_point..).first.level
    # if  @liked_customer.level < @new_level
    #     @liked_customer.update(level: @new_level)

    # end

    # # @new_level_scorecustomer = LevelSetting.where(threshold:  @liked_customer.experience_point..).first.level
    # if  @likes_customer.level <  @new_level_scorecustomer
    #     @likes_customer.update(level:  @new_level_scorecustomer)
    # end
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
