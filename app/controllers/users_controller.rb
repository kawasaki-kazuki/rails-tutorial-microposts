class UsersController < ApplicationController  
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the MICROPOSTS!" # 成功メッセージをフラッシュする
      redirect_to @user # ユーザー詳細ページにリダイレクト
    else
      # バリデーションエラー時の処理
      render :new, status: :unprocessable_entity # :unprocessable_entity ステータスを設定することで、Turboがエラーを適切に処理できるようにする
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
