class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]
  # before_action :set_user, only: %i[ show ]

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
    redirect_to tasks_path unless current_user
    admins = User.where(admin: true)
    @labels = admins.map(&:labels)
    @labels << current_user.try(:labels) if current_user.admin != true
    @labels = @labels.flatten
    @tasks = current_user.tasks.includes(:labels).desc_sort.page(params[:page]).per(10)
    # @user = User.find(params[:id]) #カレントユーザーの情報を取りたいので上記に変更
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end

end
