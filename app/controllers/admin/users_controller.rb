class Admin::UsersController < ApplicationController
  before_action :admin_user

  def new
    @user = User.new
  end

  def index
    @users = User.all.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
    @task = @user.tasks.created_at.page(params[:page]).per(8)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url(@user), notice: "ユーザー 「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ユーザー 「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice:"ユーザー 「#{@user.name}」を削除しました。"
  end


    private
    #カレントユーザーが管理者か確認し、管理者でない場合は、本人のユーザー詳細画面へ遷移させる。
    def admin_user
      redirect_to user_path(current_user.id),notice:"管理権限がありません。" unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def destroy_myself
      if @user == current_user
      redirect_to admin_users_url,
                  notice: "管理者自身を削除することは出来ません。"
    end
  end


end
