class Public::TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
    @task_comment = TaskComment.new
  end

  def reward
    @task = Task.find_by(id: params[:task_id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
    redirect_to tasks_path
    else render action: :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
    redirect_to tasks_path
    else render action: :edit
    end
  end

  def destroy
    @task = Task.find_by(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
  def task_params
      params.require(:task).permit(:title,:body,:reward,:privacy).merge(customer: current_customer)
  end


end


