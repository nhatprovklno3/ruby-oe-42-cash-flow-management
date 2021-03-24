class User < ApplicationRecord
  has_many :user_diaries, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :spending_plans, dependent: :destroy
  has_many :allow_sharings, dependent: :destroy
  enum role: {user: 0, admin: 1}
end
