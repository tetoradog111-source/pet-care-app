class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.string :species 
      t.integer :gender, default: 0, null: false
      t.integer :age
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end