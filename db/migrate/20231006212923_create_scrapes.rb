class CreateScrapes < ActiveRecord::Migration[7.1]
  def change
    create_table :scrapes do |t|
      t.text :name
      t.text :url
      t.text :format
      t.text :ref
      t.integer :retries
      t.integer :status
      t.timestamp :last_synced_at
      t.references :schedule, null: false, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
