class Public::TasksController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_customer, only: [:edit, :update ]
  before_action :correct_customer_reward, only: [:reward]
  before_action :set_task, only: %i(done update edit)

  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all.privacy_task(current_customer).page(params[:page])
    @customer = Customer.all
  end

  def show
    @task = Task.find(params[:id])
    @task_comment = TaskComment.new
  end

  def reward
    @task = Task.find_by(id: params[:task_id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスクの投稿が完了しました' }
    else
      flash.now[:alert] = 'メッセージを入力してください。'
      render action: :new
    end
  end

  def done
    @task.update(status: "Done")
    @tasks = Task.all.includes(:customer)
    current_customer.update_task_level
      redirect_to task_tasks_reward_path(@task.id),flash: { notice: 'タスク完了! 経験値が５上がりました' }
  end

  def update
    if @task.update(task_params)
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスクを変更しました' }
    else render action: :edit
    end
  end

  def destroy
 
    current_customer.tasks.find(params[:id]).destroy
    redirect_to customer_path(current_customer.id),flash: { notice: 'タスクの削除が完了しました' }
  end

private
  def task_params
    params.require(:task).permit(:title,:body,:reward,:privacy).merge(customer: current_customer)
  end

  def correct_customer
    @task = Task.find(params[:id])
    @customer = @task.customer
      redirect_to(tasks_path) unless @customer == current_customer
  end

  def correct_customer_reward
    task = Task.find(params[:task_id])
    @customer = task.customer
      redirect_to(tasks_path) unless @customer == current_customer
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end

end


