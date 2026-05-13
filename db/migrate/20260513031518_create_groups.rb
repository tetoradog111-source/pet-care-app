class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :invite_code

      t.timestamps
    end
    add_index :groups, :invite_code
  end
end
