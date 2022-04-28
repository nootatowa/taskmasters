class Public::HomesController < ApplicationController
    def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
    end
    sign_in customer
    redirect_to customer_path(current_customer.id), notice: 'ゲストユーザーとしてログインしました。'
    end
end
