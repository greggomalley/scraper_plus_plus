class CreateScrapeResults < ActiveRecord::Migration[7.1]
  def change
    create_table :scrape_results do |t|
      t.references :scrape, null: false, foreign_key: {on_delete: :cascade}
      t.json :result
      t.timestamps
    end
  end
end
