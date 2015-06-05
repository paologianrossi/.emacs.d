class VisitorsController < ApplicationController
  def landing
    render "index", layout: false
  end

  def thank_you
    @user=User.find(session[:user_id])
    render "thank_you", layout: false
  end
end
