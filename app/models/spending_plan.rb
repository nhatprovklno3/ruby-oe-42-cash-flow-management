class SpendingPlan < ApplicationRecord
  has_many :allow_sharings, dependent: :destroy
  belongs_to :user
  belongs_to :budget
  enum plan_type: {income: 0, expense: 1}
  enum status: {waiting: 0, doing: 1, finished: 2}
  enum repeat_type: {weekly: 0, monthly: 1, quarterly: 2, yearly: 3}
end
