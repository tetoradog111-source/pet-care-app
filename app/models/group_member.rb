class GroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user_id, uniqueness: { scope: :group_id, message: "は既にこのグループに参加しています" }
end
