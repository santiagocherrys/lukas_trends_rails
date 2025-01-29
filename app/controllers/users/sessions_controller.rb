# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    # Determina el path basado en si el usuario es admin o no
    default_path = current_user.ADMIN? ? admin_users_path : root_path

    # Si hay una ubicación almacenada, redirige a esa ubicación, sino utiliza el path por defecto
    path = stored_location_for(resource_or_scope) || default_path

    # Le añadimos el hash para disparar el reload en la vista
    path + '#reload'
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
