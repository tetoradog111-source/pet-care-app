class UsersController < ApplicationController
  # 登録画面を表示
  def new
    @user = User.new
  end

  # 登録ボタンを押した時の処理
  def create
    @user = User.new(user_params)
    if @user.save
      # 登録成功：ログイン画面（後ほど作成）へリダイレクト
      redirect_to login_path, success: 'ユーザー登録が完了しました'
    else
      # 登録失敗：入力画面を再表示
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end