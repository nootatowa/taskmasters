class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_customer, only: %i(show edit update)

    def index
      @customers = Customer.page(params[:page])
    end

    def update
      @customer.update(customer_params)
        redirect_to admin_customers_path
    end

    private

    def customer_params
      params.require(:customer).permit(:name, :email, :is_deleted)
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end

end
