class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:homepage]
  before_filter :correct_user?, except: [:index, :homepage]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def homepage
    @user = current_user
    render 'homepage'
  end

  def edit
    @user = User.find(params[:id])
  end
end
