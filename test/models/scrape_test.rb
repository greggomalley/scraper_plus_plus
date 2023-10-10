require "test_helper"

class ScrapeTest < ActiveSupport::TestCase
  test "a scrape is invalid without a url" do
    scrape = Scrape.new
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Url can't be blank"
  end

  test "a scrape is invalid without a name" do
    scrape = Scrape.new
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Name can't be blank"
  end

  test "a scrape is invalid without a schedule" do
    scrape = Scrape.new
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Schedule can't be blank"
  end

  test "a scrape is valid with a url, name, format, schedule, and scrape rule group" do

    scrape = Scrape.new(
      url: "https://www.example.com",
      name: "Example",
      format: "text",
      schedule: schedules(:schedule_one),
    )
    scrape.scrape_rules << ScrapeRule.new(
      name: 'the rule',
      xpath: "//div[@class='example']",
      key: "Example",
    )

    assert scrape.valid?
  end

  test "a scrape is invalid with a duplicate url" do
    scrape = Scrape.new(
      url: "https://example.com",
      name: "Example",
      format: "text",
      schedule: schedules(:schedule_one),
    )
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Url has already been taken"
  end

  test "a scrape is invalid with a duplicate name" do
    scrape = Scrape.new(
      url: "https://example.com",
      name: "scrape_one",
      format: "text",
      schedule: schedules(:schedule_one),
    )
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Name has already been taken"
  end

  test "a scape is invalid with a negative number of retries" do
    scrape = Scrape.new(
      url: "https://www.example.com",
      name: "Example",
      format: "text",
      schedule: schedules(:schedule_one),
      retries: -1
    )
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Retries must be greater than or equal to 0"
  end

  test "a scrape is invalid with a non-integer number of retries" do
    scrape = Scrape.new(
      url: "https://www.example.com",
      name: "Example",
      format: "text",
      schedule: schedules(:schedule_one),
      retries: 1.5
    )
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Retries must be an integer"
  end

  test "default retries is 0" do
    scrape = Scrape.new
    scrape.valid?
    assert_equal 0, scrape.retries
  end

  test "default format is text" do
    scrape = Scrape.new
    scrape.valid?
    assert_equal "text", scrape.format
  end

  test "default status is pending" do
    scrape = Scrape.new
    scrape.valid?
    assert_equal "pending", scrape.status
  end

  test "a scrape can have many scrape rules" do
    scrape = Scrape.new
    scrape_rule_1 = ScrapeRule.new
    scrape_rule_2 = ScrapeRule.new
    scrape.scrape_rules << scrape_rule_1 << scrape_rule_2
    assert scrape.scrape_rules.include?(scrape_rule_1)
    assert scrape.scrape_rules.include?(scrape_rule_2)
  end

  test "latest scrape result returns the most recent scrape result" do
    scrape = scrapes(:scrape_one)
    scrape_result = scrape.scrape_results.create
    assert_equal scrape_result, scrape.latest_scrape_result
  end

  test "latest scrape result returns nil if there are no scrape results" do
    scrape = scrapes(:scrape_one)
    assert_nil scrape.latest_scrape_result
  end

  test "latest scrape result returns the most recent scrape result when there is more than one result" do
    scrape = scrapes(:scrape_one)
    scrape_result_1 = scrape.scrape_results.create
    scrape_result_2 = scrape.scrape_results.create
    assert_equal scrape_result_2, scrape.latest_scrape_result
  end
end
