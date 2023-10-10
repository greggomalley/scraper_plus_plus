class CreateJoinTableScrapeScrapeRule < ActiveRecord::Migration[7.1]
  def change
    create_join_table :scrapes, :scrape_rules do |t|
      t.index [:scrape_id, :scrape_rule_id]
      t.index [:scrape_rule_id, :scrape_id]
      t.timestamps
    end
  end
end
