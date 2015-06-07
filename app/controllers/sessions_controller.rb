class SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env['omniauth.auth']
    Rails.logger.debug(auth.to_h)
    user = User.where(provider: auth['provider'], uid: auth['uid'].to_s).first ||
           User.from_omniauth(auth)
    reset_session
    session[:user_id]=user.id
    Rails.logger.debug "User: #{user.id}"
    redirect_to sioola_root_path
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Signed out"
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end
end
