class CareItem < ApplicationRecord
  belongs_to :pet
  has_many :care_records, dependent: :destroy

  # ⭕ 名前（name）の空文字を禁止するバリデーション
  validates :name, presence: true
end