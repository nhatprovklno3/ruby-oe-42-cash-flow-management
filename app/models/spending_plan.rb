class SpendingPlan < ApplicationRecord
  has_many :allow_sharings, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :budget
  enum plan_type: {income: 0, expense: 1}
  enum status: {waiting: 0, doing: 1, finished: 2}
  enum repeat_type: {weekly: 0, monthly: 1, quarterly: 2,
                     yearly: 3, not_repeat: 4}

  validates :name, presence: true,
                   length: {maximum: Settings.plan.name.max_length}
  validates :total_money, numericality: {greater_than_or_equal_to: 0}
  validates :note, presence: true,
                   length: {maximum: Settings.plan.note.max_length}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :error_date_distance

  before_create :status_for_plan
  before_create :repeat_type_for_plan

  private

  def error_date_distance
    return if end_date.blank? || start_date.blank?

    if start_date < Date.new(2020, 1, 1)
      errors.add :start_date, I18n.t("validate.error_start_day_compare")
    elsif end_date < start_date
      errors.add :end_date, I18n.t("validate.error_end_day_compare")
    end
  end

  def status_for_plan
    return self.status = SpendingPlan.statuses[:finished] if
    Time.zone.today > end_date.to_date

    return self.status = SpendingPlan.statuses[:waiting] if
    Time.zone.today < start_date.to_date

    self.status = SpendingPlan.statuses[:doing]
  end

  def repeat_type_for_plan
    return if is_repeat.to_s == "true"

    self.repeat_type = :not_repeat
  end
end
