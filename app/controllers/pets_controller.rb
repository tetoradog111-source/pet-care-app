class PetsController < ApplicationController
  before_action :require_login
  # 💡 issue15でブラッシュアップした安全な権限チェック
  before_action :ensure_group_member
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = @group.pets
  end

  def new
    @pet = @group.pets.build
  end

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
    @care_item = @pet.care_items.build
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

  # 🛠️ 修正版：endの数を完璧に合わせた安全なメソッド
  def ensure_group_member
    group_id = params[:group_id] || current_user.groups.first&.id
    
    if group_id
      @group = Group.find(group_id)
    end

    if @group.nil? || !current_user.groups.include?(@group)
      redirect_to root_path, alert: "グループの閲覧権限がないか、グループが存在しません。"
    end
  end

  def set_pet
    @pet = @group.pets.find(params[:id])
  end

  def pet_params
    # 🚀 main側にあった画像アップロード用の :avatar もしっかり残して1本化しました！
    params.require(:pet).permit(:name, :species, :age, :gender, :avatar)
  end
end