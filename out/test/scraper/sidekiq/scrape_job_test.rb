require 'test_helper'
class ScrapeJobTest < ActiveSupport::TestCase
  test "that_it_can_scrape_site_with_one_rule" do
    scrape = Scrape.create!(
      name: 'Example scrape',
      url: 'https://www.example.com/scrape',
      schedule: Schedule.create!(name: 'None', cron: nil),
    )
    scrape.scrape_store.update!(
      content: <<HTML
<!doctype html>
<html>
<head>
  <title>Example Domain</title>
</head>
<body>
  <div id="main-content">
    <ul> 
      <li>
        <p class="PromoHeadline">
          <span>Headline 1</span>
        </p>
      </li>
      <li>
        <p class="PromoHeadline">
          <span>Headline 2</span>
        </p>
      </li>
    </ul>
  </div>
</body>
</html>        
HTML
    )
    scrape_rule = ScrapeRule.create!(
      name: 'headline rule',
      xpath: '//*[@id="main-content"]//ul//li//p[contains(@class, "PromoHeadline")]/span',
      key: 'headline'
    )

    scrape.scrape_rules << scrape_rule

    ScrapeJob.new.perform(scrape.id)

    assert_equal 1, scrape.scrape_results.count
    assert_equal '[{"headline":"Headline 1"},{"headline":"Headline 2"}]', scrape.latest_scrape_result.result
  end
end
