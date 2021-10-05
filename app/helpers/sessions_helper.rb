module SessionsHelper
  def current_user #現在ログイン中のユーザーを返す（いる場合）
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def current_user?(user)
    user == current_user
  end #受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
end
