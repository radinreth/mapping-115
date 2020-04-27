class User < ApplicationRecord
  belongs_to :location, counter_cache: :callers_count

  validates :phone_number, presence: true
  validates :ncdd_code, presence: true
end
