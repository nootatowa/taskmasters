class Public::CardsController < ApplicationController
  def new
    @card = Card.new
    @task = Task.find_by(id: params[:task_id])
  end

  def show
    @card = Card.find_by(id: params[:id])
  end

  def create
    @task = Task.find_by(id: params[:task_id])
    @card = Card.new(card_params)
    if @card.save
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスク詳細を追加しました' }
    else
      render action: :new
    end
  end

  def edit
    @card = Card.find_by(id: params[:id])
  end

  def update
    @card = Card.find_by(id: params[:id])
    if @card.update(card_params)
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスク詳細を変更しました' }
    else
      render action: :edit
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
      redirect_to customer_path(current_customer.id),flash: { notice: 'タスク詳細を削除しました' }
  end

  private
  def card_params
    params.require(:card).permit(:title, :memo, :task_id)
  end

end
