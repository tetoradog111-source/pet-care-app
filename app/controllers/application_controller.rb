class ApplicationController < ActionController::Base
  private

  def reject_non_group_members
    # 💡 URLに group_id または id が含まれている場合だけ取得する
    group_id = params[:group_id] || params[:id]
    
    # 🚀 安全対策：もしどちらのIDもURLに含まれていない（一覧画面などの）場合は、
    # そもそも特定のグループを判定する必要がないので、チェックをスルーして次に進ませる！
    return if group_id.nil?

    @current_group = Group.find_by(id: group_id)

    # 💡 IDがあるのにグループが見つからない、または自分が所属していない場合だけ厳しく弾く
    if @current_group.nil? || !current_user.groups.include?(@current_group)
      redirect_to root_path, alert: "所属していないグループの情報にはアクセスできません。"
    end
  end
end