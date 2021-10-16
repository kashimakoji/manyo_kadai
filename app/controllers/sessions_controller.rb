class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]

  def new
    redirect_to tasks_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) #ログインボタンを押した後セッションに情報が保存されるか判断
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      # binding.irb
      # flash.now[:danger] = 'ログインしました'

      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    # binding.irb
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

end
