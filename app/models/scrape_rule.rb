class ScrapeRule < ApplicationRecord
  has_many :scrape_rules_scrapes
  has_many :scrapes, through: :scrape_rules_scrapes

  enum scrape_type: [:list, :single_item, :object_list, :object_single_item]

  validates :xpath, presence: true
  validates :name, presence: true, uniqueness: true
  validates :scrape_type, presence: true, inclusion: { in: scrape_types.keys }

  before_validation :set_default_type, on: :create

  private

  def set_default_type
    self.scrape_type ||= 'list'
  end
end
