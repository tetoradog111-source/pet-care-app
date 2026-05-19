class CreateCareRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :care_records do |t|
      # 💡 null: false を追記
      t.references :pet, null: false, foreign_key: true
      t.references :care_item, null: false, foreign_key: true
      t.datetime :recorded_at, null: false

      t.timestamps
    end
    
    add_index :care_records, [:pet_id, :care_item_id, :recorded_at], unique: true, name: 'index_care_records_on_pet_item_and_time'
  end
end
