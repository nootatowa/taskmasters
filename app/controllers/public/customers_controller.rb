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
