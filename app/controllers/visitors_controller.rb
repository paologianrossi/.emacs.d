class VisitorsController < ApplicationController
  def landing
    if user_signed_in?
      redirect_to :thank_you
    else
      render "landing", layout: false
    end
  end

  def thank_you
    if user_signed_in?
      @user=User.find(session[:user_id])
      render "thank_you", layout: false
    else
      redirect_to root_url
    end
  end
end
