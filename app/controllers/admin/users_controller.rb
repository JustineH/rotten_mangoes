class Admin::UsersController < ApplicationController

  # before_filter :restrict_access
  before_filter :admin_restrict_access

  def index
    @users = User.page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.full_name} has been added!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to '/admin/users'
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:id, :email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end