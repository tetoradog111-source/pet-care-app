class GroupMembersController < ApplicationController
  before_action :require_login

  def new
    # 招待コードを入力するだけの画面なので、特別なインスタンス変数は不要です
  end

  def create
    # 入力されたコードでグループを検索
    group = Group.find_by(invite_code: params[:invite_code])

    if group
      # 二重参加バリデーションに引っかからないかチェックしつつ保存
      if group.users.include?(current_user)
        redirect_to new_group_member_path, alert: "既にそのグループに参加しています"
      else
        group.users << current_user
        redirect_to group_path(group), notice: "#{group.name} に参加しました！"
      end
    else
      # グループが見つからない場合
      flash.now[:alert] = "招待コードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end
end