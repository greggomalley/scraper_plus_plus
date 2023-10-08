class Schedule < ApplicationRecord
  has_many :scrapes

  validates :name, presence: true, uniqueness: true
  validates :cron, presence: true, uniqueness: true
  validate :valid_cron_expression

  private

  def valid_cron_expression
    unless Fugit::Cron.parse(cron)
      errors.add(:cron, 'is not a valid cron expression')
    end
  end
end
