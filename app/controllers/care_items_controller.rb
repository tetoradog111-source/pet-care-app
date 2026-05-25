class CareItemsController < ApplicationController
  before_action :require_login
  before_action :set_pet
  before_action :reject_non_group_members

  def create
    # ペットに紐づく新しいお世話項目を作成
    @care_item = @pet.care_items.build(care_item_params)
    
    if @care_item.save
      redirect_to group_pet_path(@pet.group, @pet), notice: 'お世話項目を追加しました！'
    else
      # エラーがあった場合は詳細画面に戻る（バリデーション用）
      # リダイレクトだとフラッシュメッセージが消えやすいため、showのデータを再準備してrenderします
      @group = @pet.group
      flash.now[:alert] = 'お世話項目の追加に失敗しました'
      render 'pets/show', status: :unprocessable_entity
    end
  end

  def destroy
    care_item = @pet.care_items.find(params[:id])
    care_item.destroy
    redirect_to group_pet_path(@pet.group, @pet), notice: 'お世話項目を削除しました。', status: :see_other
  end

  private

  def set_pet
    # URLの /pets/:pet_id/ からペットを特定
    @pet = Pet.find(params[:pet_id])
  end

  def care_item_params
    params.require(:care_item).permit(:name)
  end
end