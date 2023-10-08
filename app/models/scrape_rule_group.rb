class ScrapeRuleGroup < ApplicationRecord
  has_many :scrape_rules
  belongs_to :scrape, inverse_of: :scrape_rule_groups
  accepts_nested_attributes_for :scrape_rules, reject_if: :all_blank, allow_destroy: true

  validates :scrape, presence: true
end
