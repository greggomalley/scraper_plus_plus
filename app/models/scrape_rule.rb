class ScrapeRule < ApplicationRecord
  belongs_to :scrape, inverse_of: :scrape_rules
  validates :xpath, presence: true
end
