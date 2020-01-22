class UsersController < ApplicationController
  skip_before_action :login_required #非ログイン時にログイン画面へ遷移する処理をスキップ。
  before_action :verification_user, {only: [:show]} #他のユーザー詳細へ遷移しようとしたら、自分の詳細画面へ遷移させる。

  def new
    if current_user.present? #ログイン中であれば、ユーザープロフィール画面へ
      redirect_to user_path(current_user)
    else
      @user = User.new #ログイン中でなければ、新規アカウント作成へ
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id #新規アカウント作成をしたら、同時にログインできる記述。
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def verification_user #他のユーザー詳細へ遷移しようとしたら、自分の詳細画面へ遷移させる。
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
