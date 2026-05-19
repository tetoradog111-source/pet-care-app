class CareRecord < ApplicationRecord
  belongs_to :pet
  belongs_to :user
  belongs_to :care_item

  validates :recorded_at, presence: true

  validates :care_item_id, uniqueness: { scope: [:pet_id, :recorded_at], message: "同じ時間に同じお世話が既に記録されています" }
end
