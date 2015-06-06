class VisitorsController < ApplicationController
  def homepage
    render "landing", layout: false
  end

  def thank_you
      @user=User.find(current_user)
      render "thank_you", layout: false
  end
end
