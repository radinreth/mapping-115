# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  phone_number  :string           not null
#  lat           :float
#  lng           :float
#  last_datetime :datetime
#  ncdd_code     :string           not null
#  location_id   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :location

  validates :phone_number, presence: true
  validates :ncdd_code, presence: true
end
