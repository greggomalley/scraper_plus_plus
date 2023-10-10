json.extract! scrape_result, :id, :created_at, :updated_at
json.url scrape_result_url(scrape_result, format: :json)
