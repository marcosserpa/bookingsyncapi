class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize
    if params[:token_auth] == 'ABCDE_BookyngSync'
      true
    else
      render json: { message: 'Unauthorized access' }, status: 401
    end
  end
end
