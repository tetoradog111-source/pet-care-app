class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      # 🚀 修正：status: :see_other を必ず追加して、本番環境のTurboフリーズを撃退します！
      redirect_to groups_path, notice: "ログインしました", status: :see_other
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, notice: 'ログアウトしました'
  end
end