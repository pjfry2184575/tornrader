class Trade < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: :slugged

  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items

  before_create do 
    self.slug = SecureRandom.uuid
  end

  def update_total
    total_price = self.line_items.pluck(:total).sum
    self.update!(total: total_price) unless self.total == total_price
  end

  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end
end