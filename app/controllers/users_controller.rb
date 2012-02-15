class UsersController < ApplicationController
  def new
    @title = 'Sign Up'
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
     @user = User.new(params[:user])
    if @user.save
      puts 'Saved!'
      redirect_to @user
      flash[:success] = "Welcome to the Pages App!"
    else
      render 'new'
    end

  end

end
