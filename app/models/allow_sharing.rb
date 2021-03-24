class AllowSharing < ApplicationRecord
  belongs_to :user
  belongs_to :spending_plan
end
