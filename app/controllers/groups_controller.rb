class GroupsController < ApplicationController
  # ログインしていないとグループ作成できないようにする
  before_action :require_login
  before_action :reject_non_group_members

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      # グループ作成者を最初のメンバーとして登録
      @group.users << current_user
      redirect_to group_path(@group), notice: 'グループを作成しました！招待コードを家族に共有しましょう。'
    else
      flash.now[:alert] = 'グループの作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end