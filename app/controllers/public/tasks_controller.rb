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

  def done
    @task = Task.find_by(id: params[:id])
    @task.update(status: "Done")
    @tasks = Task.all.includes(:customer)

    @done_customer = current_customer
    @done_customer.update(experience_point: @done_customer.experience_point + 5)
    @new_level_task_customer = LevelSetting.where(threshold:  @done_customer.experience_point..).first.level
    if  @done_customer.level < @new_level_task_customer
        @done_customer.update(level: @new_level_task_customer)
    end

    redirect_to task_tasks_reward_path(@task.id)
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
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
  def task_params
      params.require(:task).permit(:title,:body,:reward,:privacy).merge(customer: current_customer)
  end


end


