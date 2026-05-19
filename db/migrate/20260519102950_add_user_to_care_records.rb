class AddUserToCareRecords < ActiveRecord::Migration[7.0]
  def change
    add_reference :care_records, :user, null: false, foreign_key: true
  end
end
