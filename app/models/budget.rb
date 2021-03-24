class Budget < ApplicationRecord
  has_many :spending_plans, dependent: :destroy
  belongs_to :user
end
