class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization
  # include Pundit#::Authorization

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  # As actions acima estão funcionando mas apenas quando estão sozinhas. sendo que eu quero que aceite uma lista de actions

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name age photo])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name age photo])
  end

  private

  def skip_pundit?
    # devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ # || params[:controller] == "pages" || params[:controller] == "devises"
  end
end
