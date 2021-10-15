class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]
  before_action :set_user, only: %i[ show ]

  def new
    redirect_to tasks_path if current_user.present?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザーを登録しました'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    # @user = User.find(params[:id])
    redirect_to tasks_path if current_user != @user
    @tasks = @user.tasks.page(params[:page]).per(10)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
