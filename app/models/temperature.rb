class Temperature < ApplicationRecord
  validates :netu, presence: true

  belongs_to :user
  belongs_to :addition
end
