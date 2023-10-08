require "test_helper"

class ScheduleTest < ActiveSupport::TestCase
  test "a schedule is invalid without a name" do
    schedule = Schedule.new
    refute schedule.valid?
    assert_includes schedule.errors.full_messages, "Name can't be blank"
  end

  test "a schedule is invalid without a cron" do
    schedule = Schedule.new
    refute schedule.valid?
    assert_includes schedule.errors.full_messages, "Cron can't be blank"
  end
end
