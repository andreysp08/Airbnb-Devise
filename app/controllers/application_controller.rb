class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  after_action :verify_authorized, except: %i[home index].last, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: %i[home index].last, unless: :skip_pundit?
  # As actions acima estão funcionando mas apenas quando estão sozinhas. sendo que eu quero que aceite uma lista de actions

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name age photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name age photo])
  end

  private

  def skip_pundit?
    # devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/# || params[:controller] == "pages" || params[:controller] == "devises"
  end
end
