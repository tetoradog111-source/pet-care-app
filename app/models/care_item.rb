class CareItem < ApplicationRecord
  belongs_to :pet

  # ⭕ 名前（name）の空文字を禁止するバリデーション
  validates :name, presence: true
end