class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  helper_method :current_user, :log_in?
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  #ログインしていない時はログイン画面へ遷移させる記述。
  def login_required
    redirect_to new_session_path unless current_user
  end

  #ログインしていないときやマイページなどに飛ばないようにする
  def authenticate_user
    if current_user == nil
      redirect_to new_session_path
    end
  end

  def admin?
    @user.admin
  end

  def log_in?
    @current_user.present?
  end

end

  #
  # before_action :user_logged_in?
  #
  # def user_logged_in?
  #   if session[:user_id]
  #     begin
  #       @current_user = User.find_by(user_id: session[:user_id])
  #     rescue ActiveRecord::RecordNotFound
  #       reset_user_session
  #     end
  #   end
  #   return if @current_user
  #   # @current_userが取得できなかった場合はログイン画面にリダイレクト
  #   flash[:referer] = request.fullpath
  #   redirect_to new_session_path
  # end
  #
  # def reset_user_session
  #   session[:user_id] = nil
  #   @current_user = nil
  # end
