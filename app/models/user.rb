class User < ApplicationRecord
  belongs_to :location

  validates :phone_number, presence: true
  validates :ncdd_code, presence: true
end
