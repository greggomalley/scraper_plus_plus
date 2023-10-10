class CreateScrapeStores < ActiveRecord::Migration[7.1]
  def change
    create_table :scrape_stores do |t|
      t.text :content
      t.references :scrape, null: false, foreign_key: true
      t.timestamps
    end
  end
end
