class PetsController < ApplicationController
  before_action :require_login
  before_action :ensure_group_member
  # 💡 :new や :create は、特定の1匹のペットを特定する前なので、:set_pet からは除外しておきます
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = @group.pets
  end

  # 💡 新しく追加：新規登録画面を表示するアクション
  def new
    @pet = @group.pets.build # または @pet = Pet.new
  end

  # 💡 新しく追加（あるいは修正）：フォームから送信されたデータを保存するアクション
  def create
    @pet = @group.pets.build(pet_params)
    if @pet.save
      redirect_to group_path(@group), notice: 'ペットを新しく登録しました！'
    else
      flash.now[:alert] = 'ペットの登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to group_pet_path(@group, @pet), notice: 'ペットの情報を更新しました！'
    else
      flash.now[:alert] = 'ペット情報の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to group_path(@group), notice: 'ペットの情報を削除しました。', status: :see_other
  end

  private

  def ensure_group_member
    @group = Group.find(params[:group_id])
    unless current_user.groups.include?(@group)
      redirect_to groups_path, alert: "このグループの情報を閲覧する権限がありません。"
    end
  end

  def set_pet
    @pet = @group.pets.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :age, :gender)
  end
end
