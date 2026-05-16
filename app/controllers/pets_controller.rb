class PetsController < ApplicationController
  before_action :require_login

  def new
    @group = current_user.groups.find(params[:group_id])
    @pet = @group.pets.build
  end

  def create
    @group = current_user.groups.find(params[:group_id])
    @pet = @group.pets.build(pet_params)
    if @pet.save
      redirect_to group_path(@group), notice: "ペット「#{@pet.name}」を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :gender, :age)
  end
end