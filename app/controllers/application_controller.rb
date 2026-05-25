class ApplicationController < ActionController::Base
    private

  def reject_non_group_members
    group_id = params[:group_id] || params[:id]
    @current_group = Group.find_by(id: group_id)

    if @current_group.nil? || !current_user.groups.include?(@current_group)
      redirect_to root_path, alert: "所属していないグループの情報にはアクセスできません。"
    end
  end
end
