class Pet < ApplicationRecord
  belongs_to :group

  validates :name, presence: true
  # 性別などをenumで管理すると便利です
  enum :gender, { unknown: 0, male: 1, female: 2 }

  def gender_text
    case gender
    when 'male'   then '男の子'
    when 'female' then '女の子'
    else               '不明'
    end
  end
end
