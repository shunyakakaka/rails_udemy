class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    else
      return
    end
  end
end
