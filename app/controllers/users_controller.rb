class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update following followers]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def edit
    # @user は `set_user` メソッドでセットされます
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to the MICROPOSTS!' # 成功メッセージをフラッシュする
      redirect_to @user # ユーザー詳細ページにリダイレクト
    else
      # バリデーションエラー時の処理
      render :new, status: :unprocessable_entity # :unprocessable_entity ステータスを設定することで、Turboがエラーを適切に処理できるようにする
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'following_followers'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.follower_users
    render 'following_followers'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :area, :password, :password_confirmation)
  end
end
