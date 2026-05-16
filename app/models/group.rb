class Group < ApplicationRecord
  # 保存の直前に実行されるコールバック
  before_create :generate_invite_code

  # バリデーション：グループ名は必須
  validates :name, presence: true
  # 招待コードはユニーク（重複なし）にする
  validates :invite_code, uniqueness: true
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
  has_many :pets, dependent: :destroy

  private

  def generate_invite_code
    # 10桁のランダムな英数字を生成して代入
    self.invite_code = SecureRandom.alphanumeric(10)
  end
end

