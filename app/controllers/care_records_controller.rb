class CareRecordsController < ApplicationController
  before_action :require_login
  before_action :set_pet

  def index
    @care_records = @pet.care_records
                        .includes(:care_item, :user)
                        .order(recorded_at: :asc)
  end

  def create
    @care_record = @pet.care_records.build(
      care_item_id: params[:care_item_id],
      recorded_at: Time.current,
      user_id: current_user.id 
    )

    if @care_record.save
      redirect_to group_pet_path(@pet.group, @pet), notice: "お世話（#{@care_record.care_item.name}）を記録しました！"
    else
      redirect_to group_pet_path(@pet.group, @pet), alert: @care_record.errors.full_messages.to_sentence
    end
  end
  def destroy
    @care_record = @pet.care_records.find(params[:id])
    @care_record.destroy
    redirect_to group_pet_path(@pet.group, @pet), notice: 'お世話の記録を取り消しました。', status: :see_other
  end

  private

  def set_pet
    @group = Group.find(params[:group_id])
    @pet = Pet.find(params[:pet_id])
  end
end
