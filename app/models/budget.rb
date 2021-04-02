class Budget < ApplicationRecord
  has_many :spending_plans, dependent: :destroy
  belongs_to :user
  has_many :child_budgets, class_name: Budget.name, foreign_key: :parent_id,
    dependent: :destroy
  belongs_to :parent, class_name: Budget.name, optional: true

  validates :name, presence: true
  validates :money, presence: true, numericality: {greater_than_or_equal_to: 0}
  validate :total_money_validator, if: ->{money && parent_id}
  scope :where_parent, ->{where(parent_id: nil)}
  scope :order_by_creat_at_desc, ->{order(created_at: :desc)}
  scope :search_by_name, ->(name){where("name LIKE ?", "%#{name}%")}
  scope :search_by_money_range, (lambda do |from_money, to_money|
    where("money between ? and ?", from_money, to_money)
  end)
  scope :search_by_from_money, ->(from_money){where("money > ?", from_money)}
  scope :search_by_to_money, ->(to_money){where("money < ?", to_money)}

  def total_money_validator
    return unless parent_budget = Budget.find_by(id: parent_id)

    total_money = money + parent_budget.child_budgets.sum(:money)
    return if total_money < parent_budget.money

    errors.add(:money, I18n.t("budget.money_error"))
  end
end
