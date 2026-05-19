class CreateCareItems < ActiveRecord::Migration[7.0]
  def change
    create_table :care_items do |t|
      # 💡 null: false を追記してデータベース側でも空登録を防ぐ
      t.references :pet, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end