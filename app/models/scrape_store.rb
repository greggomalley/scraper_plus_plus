class ScrapeStore < ApplicationRecord
  belongs_to :scrape

  validates_presence_of :scrape
end
