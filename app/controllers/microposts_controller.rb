class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      render 'static_pages/home'
    end
  end

  def destroy
    # ユーザーに紐づくMicropostを、指定されたIDから探す
    @micropost = current_user.microposts.find_by(id: params[:id])

    # Micropostが見つからない場合、root_urlにリダイレクト
    if @micropost.nil?
      flash[:alert] = 'Micropost not found'
      return redirect_to root_url
    end

    # Micropostが見つかった場合、削除を行う
    if @micropost.destroy
      flash[:success] = 'Micropost deleted'
    else
      flash[:error] = 'Failed to delete Micropost'
    end

    # 削除後、元のページに戻るか、root_urlにリダイレクト
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
