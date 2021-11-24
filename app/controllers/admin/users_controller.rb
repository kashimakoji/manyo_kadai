class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    redirect_to tasks_path, notice: "一般ユーザーは管理画面に入れません" unless current_user.admin?
    # @users = User.includes(:tasks).all
    @users = User.includes(:tasks).all
    # @users = User.preload(:tasks)
    # @users = User.eager_load(:tasks)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: "ユーザー「#{@user.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if
      @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
    else
      redirect_to admin_users_path, notice: "管理者は一人以上必要です"
      # render :index
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
