class CreateScrapeRules < ActiveRecord::Migration[7.1]
  def change
    create_table :scrape_rules do |t|
      t.text :name, null: false, index: true
      t.text :xpath
      t.text :key
      t.integer :scrape_type
      t.references :parent, null: true, foreign_key: { to_table: :scrape_rules }, index: true
      t.timestamps
    end
  end
end
