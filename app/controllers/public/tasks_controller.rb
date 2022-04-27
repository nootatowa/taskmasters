class Public::TasksController < ApplicationController
  before_action :correct_customer, only: [:edit, :updategit ]
  before_action :correct_customer_reward, only: [:reward]

  def new
      @task = Task.new
  end

  def index
      @tasks = Task.where.not("privacy = 2 AND customer_id <> #{current_customer.id}").page(params[:page])
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
      @task = Task.find_by(id: params[:id])
      @task.update(status: "Done")
      @tasks = Task.all.includes(:customer)

      @done_customer = current_customer
      @done_customer.update(experience_point: @done_customer.experience_point + 5)
      result = LevelSetting.where("threshold <= ?", @done_customer.experience_point)
      if result.any?
        if @done_customer.level != result.last.level
           @done_customer.level = result.last.level
           @done_customer.save
        end
      end

    redirect_to task_tasks_reward_path(@task.id),flash: { notice: 'タスク完了! 経験値が５上がりました' }
  end

  def edit
      @task = Task.find_by(id: params[:id])
  end

  def update
      @task = Task.find_by(id: params[:id])
      if @task.update(task_params)
        redirect_to customer_path(current_customer.id),flash: { notice: 'タスクを変更しました' }
      else render action: :edit
      end
  end

  def destroy
      @task = Task.find(params[:id])
      @task.destroy
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

end