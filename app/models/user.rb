class User < ApplicationRecord
  validates :name, presence: true
  validates :birthday, presence: true
end
