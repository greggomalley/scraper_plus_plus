class Scrape < ApplicationRecord
  belongs_to :schedule
  # has_many :scrape_rule_groups, dependent: :destroy, inverse_of: :scrape
  has_many :scrape_rules, dependent: :destroy, inverse_of: :scrape

  # accepts_nested_attributes_for :scrape_rule_groups, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :scrape_rules, reject_if: :all_blank, allow_destroy: true

  enum format: { text: 'text', json: 'json' }
  enum status: { pending: 0, running: 1, success: 2, failed: 3 }

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :format, presence: true
  validates :ref, presence: true
  validates :retries, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :schedule, presence: true
  validates :scrape_rule_groups, presence: true

  before_validation :set_default_retries, on: :create
  before_validation :set_default_format, on: :create
  before_validation :set_default_status, on: :create
  before_validation :set_default_ref, on: :create

  def to_param
    ref
  end

  private

  def set_default_retries
    self.retries ||= 0
  end

  def set_default_format
    self.format ||= 'text'
  end

  def set_default_status
    self.status ||= 'pending'
  end

  def set_default_ref
    self.ref ||= Haiku.call
  end
end
