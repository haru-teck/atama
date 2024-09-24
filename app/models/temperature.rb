class Temperature < ApplicationRecord
  validates :netu, presence: true

  belongs_to :user
  has_one :addition, dependent: :destroy
  
end
