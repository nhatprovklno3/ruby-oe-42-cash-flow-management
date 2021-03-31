class Budget < ApplicationRecord
  has_many :spending_plans, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :money, presence: true, numericality: {greater_than_or_equal_to: 0}
  validate :total_money_validator, if: ->{money && parent_id}

  def total_money_validator
    total_money = money + Budget.where(parent_id: parent_id).sum(:money)
    return unless parent_budget = Budget.find_by(id: parent_id)

    return if total_money < parent_budget.money

    errors.add(:money, I18n.t("budget.money_error"))
  end
end
