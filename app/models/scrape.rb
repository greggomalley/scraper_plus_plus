class Scrape < ApplicationRecord
  belongs_to :schedule

  has_one :scrape_store, dependent: :destroy, autosave: true
  has_many :scrape_rules_scrapes
  has_many :scrape_rules, through: :scrape_rules_scrapes
  has_many :scrape_results, dependent: :destroy

  enum format: { text: 'text', json: 'json' }
  enum status: { pending: 0, running: 1, success: 2, failed: 3 }

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :format, presence: true
  validates :ref, presence: true
  validates :retries, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :schedule, presence: true

  before_validation :set_default_retries, on: :create
  before_validation :set_default_format, on: :create
  before_validation :set_default_status, on: :create
  before_validation :set_default_ref, on: :create

  after_create :initialise_scrape_store
  after_create :schedule_scrape_job
  after_destroy :unschedule_scrape_job

  def latest_scrape_result
    scrape_results.order('created_at DESC').first
  end

  private

  def initialise_scrape_store
    build_scrape_store unless scrape_store
  end

  def schedule_scrape_job
    return if schedule.cron.blank?
    Sidekiq::Cron::Job.new(
      name: name,
      cron: schedule.cron,
      class: 'ScrapeJob',
    )
  end

  def unschedule_scrape_job
    return if schedule.cron.blank?
    Sidekiq::Cron::Job.destroy(name)
  end

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
