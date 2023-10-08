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

  test "a scrape is invalid without a scrape rule group" do
    scrape = Scrape.new
    refute scrape.valid?
    assert_includes scrape.errors.full_messages, "Scrape rule groups can't be blank"
  end

  test "a scrape is valid with a url, name, format, schedule, and scrape rule group" do
    scrape_rule_group = ScrapeRuleGroup.new
    ScrapeRule.new(
      xpath: "//div[@class='example']",
      key: "Example",
      scrape_rule_group: scrape_rule_group
    )

    scrape = Scrape.new(
      url: "https://www.example.com",
      name: "Example",
      format: "text",
      schedule: schedules(:schedule_one),
      scrape_rule_groups: [scrape_rule_group]
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

  test "a scrape can have many scrape rule groups" do
    scrape = Scrape.new
    scrape_rule_group_1 = ScrapeRuleGroup.new
    scrape_rule_group_2 = ScrapeRuleGroup.new
    scrape.scrape_rule_groups << scrape_rule_group_1 << scrape_rule_group_2
    assert scrape.scrape_rule_groups.include?(scrape_rule_group_1)
    assert scrape.scrape_rule_groups.include?(scrape_rule_group_2)
  end

  test "a scrape can have many scrape rules through scrape rule groups" do
    scrape = Scrape.new
    scrape_rule_group = ScrapeRuleGroup.new
    scrape_rule_1 = ScrapeRule.new
    scrape_rule_2 = ScrapeRule.new
    scrape_rule_group.scrape_rules << scrape_rule_1 << scrape_rule_2
    scrape.scrape_rule_groups << scrape_rule_group
    assert scrape.scrape_rules.include?(scrape_rule_1)
    assert scrape.scrape_rules.include?(scrape_rule_2)
  end

  test "a scrape nested attributes for scrape rule groups can be destroyed" do
    scrape = Scrape.new
    scrape_rule_group = ScrapeRuleGroup.new
    scrape.scrape_rule_groups << scrape_rule_group
    scrape.save
    assert scrape.scrape_rule_groups.include?(scrape_rule_group)
    scrape.update(scrape_rule_groups_attributes: [{ id: scrape_rule_group.id, _destroy: true }])
    refute scrape.scrape_rule_groups.include?(scrape_rule_group)
  end
end
