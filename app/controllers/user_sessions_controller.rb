class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      group = @user.groups.first

      # 🚀 修正：グループが存在すれば、そのグループの「ペット一覧画面」へ一直線！
      if group
        redirect_to group_pets_path(group), notice: "ログインしました"
      else
       redirect_to new_pet_path, notice: "ログインしました！まずはペットを登録してみましょう！"
      end
          
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