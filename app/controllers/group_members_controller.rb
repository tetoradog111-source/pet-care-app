class GroupMembersController < ApplicationController
  before_action :require_login
  # 🚀 修正：まだ参加していない人がアクセスする場所なので、reject_non_group_members は削除しました！

  def create
    # 入力されたコードでグループを検索
    group = Group.find_by(invite_code: params[:invite_code])

    if group
      # 二重参加を防止
      if group.users.include?(current_user)
        redirect_to groups_path, alert: "既にそのグループに参加しています"
      else
        group.users << current_user
        redirect_to groups_path, notice: "「#{group.name}」に参加しました！"
      end
    else
      # 🚀 修正：一覧画面（groups_path）のフォームから送信されるため、
      # エラー時も groups_path に戻してお知らせ（alert）を表示します
      redirect_to groups_path, alert: "招待コードが正しくありません"
    end
  end
end