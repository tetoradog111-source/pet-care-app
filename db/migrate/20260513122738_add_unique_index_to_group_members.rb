class AddUniqueIndexToGroupMembers < ActiveRecord::Migration[7.0]
  def change
    # user_id と group_id の組み合わせをユニークにする
    add_index :group_members, [:user_id, :group_id], unique: true
  end
end