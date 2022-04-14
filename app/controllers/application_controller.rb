class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?


before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    customer_path(current_customer.id)
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
   def not_authenticated
    flash[:info] = 'ログインしてください'
    redirect_to main_app.login_path #main_appのプレフィックスをつける
   end
end
