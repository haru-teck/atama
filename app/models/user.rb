class User < ApplicationRecord
  validates :name, presence: true
  validates :birthday, presence: true

  has_many :temperatures
end
