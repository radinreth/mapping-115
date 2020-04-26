class Location < ApplicationRecord
  has_many :callers, class_name: 'User', dependent: :destroy

  validates :code, :name_en, :name_km, :kind, presence: true
  validates_inclusion_of :kind, in: %w[province district commune village], message: 'type %{value} is invalid'
  validates :lat, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_blank: true
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_blank: true
  validate :presence_of_latlng

  has_many :children, class_name: 'Location', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Location', optional: true

  def nested_count(obj = self, count = 0)
    return obj.callers.count unless obj.children.exists?

    obj.children.each do |c|
      count += (obj.callers.count + nested_count(c, c.callers.count))
    end

    count
  end

  def self.location_kind(code)
    return if code.blank?

    dict = { '2': 'province', '4': 'district', '6': 'commune' }
    dict[code.length.to_s.to_sym] || 'village'
  end

  private

  def presence_of_latlng
    return if lat.present? && lng.present?

    errors.add(:lng, "can't be blank") if lat.present?
    errors.add(:lat, "can't be blank") if lng.present?

    throw :abort
  end
end
