class AllowSharing < ApplicationRecord
  belongs_to :user
  belongs_to :spending_plan
  validates :user, presence: true
  validates :spending_plan, presence: true
end
