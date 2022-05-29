class Public::CardsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_customer, only: [:edit, :update,:destroy,:edit]
  before_action :correct_customer_new, only: [:new]
  before_action :set_card, only: %i(show  update edit)
  before_action :set_task_card, only: %i(new show)
  before_action :set_task_id, only: %i(new create)


  def new
    if params[:task_id].to_i == @task.id
    @card = Card.new
    else
      redirect_to(tasks_path)
    end
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスク詳細を追加しました' }
    else
      render action: :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスク詳細を変更しました' }
    else
      render action: :edit
    end
  end

  def destroy
      @card = Card.find(params[:id])
      @card.destroy
      # @card.current_customer.task.destroy
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスク詳細を削除しました' }
  end

  private

  def card_params
    params.require(:card).permit(:title, :memo, :task_id)
  end

  def correct_customer
    @card = Card.find(params[:id])
    @customer = @card.task.customer
      redirect_to(tasks_path) unless @customer == current_customer
  end

  def correct_customer_new
    task = Task.find(params[:task_id])
    @customer = task.customer
      redirect_to(tasks_path) unless @customer == current_customer
  end


  def set_card
    @card = Card.find_by(id: params[:id])
  end

  def set_task_card
    @task = Task.find_by(id: params[:task_id])
  end

  def set_task_id
   @task = Task.find(params[:task_id])
  end
end
