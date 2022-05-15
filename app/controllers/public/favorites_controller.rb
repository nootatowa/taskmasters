class Public::FavoritesController < ApplicationController
  before_action :set_favorite, only: %i(create destroy)

  def create
    favorite = current_customer.favorites.new(task_id: @task.id)
    favorite.save
    current_customer.update_level
  end

  def destroy
    favorite = current_customer.favorites.find_by(task_id: @task.id)
    favorite.destroy
  end

 private

  def set_favorite
    @task = Task.find(params[:task_id])
  end

end
