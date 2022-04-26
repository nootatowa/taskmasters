class Public::CustomersController < ApplicationController


    def show
    @customer = Customer.find(params[:id])
    @task = Task.find_by(id: params[:id])
    @tasks = @customer.tasks.page(params[:page])
    end

    def edit
      @customer = current_customer
    end

    def update
      @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to tasks_path,flash: { notice: '名前を変更しました' }
    else
      render :edit,flash: { alert: '文字を入力してください' }
    end
    end

    def unsubscribe
     @customer = current_customer
    end

    def withdraw
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path,flash: { notice: '退会が完了しました' }
    end



    def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:task_id)
    @favorite_tasks = Task.where(id: favorites)
    end

   private
    def customer_params
    params.require(:customer).permit(:name)
    end
end
