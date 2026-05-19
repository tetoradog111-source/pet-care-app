class Pet < ApplicationRecord
  belongs_to :group
  has_many :care_items, dependent: :destroy
  has_many :care_records, dependent: :destroy

  validates :name, presence: true
  validates :species, presence: true

  # 💡 クラスの中に正しく収めました
  # 性別などをenumで管理すると便利です
  enum :gender, { unknown: 0, male: 1, female: 2 }

  def gender_text
    case gender
    when 'male'   then '男の子'
    when 'female' then '女の子'
    else               '不明'
    end
  end
end # 💡 クラスの閉じタグは一番最後になります！
