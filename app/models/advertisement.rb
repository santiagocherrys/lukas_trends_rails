class Advertisement < ApplicationRecord
  validates :image_url, :title, :link, presence: true

  def self.random_banner
    order(Arel.sql('RANDOM()')).first
  end
end
