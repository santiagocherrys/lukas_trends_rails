class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def change_user_subscription_type
    parameters = change_user_subscription_type_params
    user = User.find(parameters[:user_id])
    user.subscription_type = parameters[:subscription_type].to_i

    if user.save
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'El tipo de suscripcion ha cambiado exitosamente ' }
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_users_path, alert: 'Fallo al cambiar el tipo de suscripcion' }
      end
    end
  end

  private

  def change_user_subscription_type_params
    params.permit(:subscription_type, :user_id)
  end

  def authenticate_admin!
    return if current_user&.ADMIN?

    redirect_to root_path, alert: 'No tienes permiso para acceder a esta sección.'
  end
end
