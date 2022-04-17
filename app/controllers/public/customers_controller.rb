class Public::CustomersController < ApplicationController


    def show
    @customer = Customer.find(params[:id])
    @tasks = @customer.tasks
    end

    def edit
      @customer = current_customer
    end

    def update
      @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to tasks_path
    else
      render :edit
    end
    end

    def unsubscribe
     @customer = current_customer
    end

    def withdrawal
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
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
