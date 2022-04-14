class Public::CustomersController < ApplicationController

    def show
    @customer = Customer.find(params[:id])
    @tasks = @customer.tasks
    # @task = Task.new
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
   private
    def customer_params
    params.require(:customer).permit(:name)
    end
end
