class ScrapeJob
  include Sidekiq::Job

  sidekiq_options queue: 'scraper'

  def perform(scrape_id)
    scrape = Scrape.find(scrape_id)
    return unless scrape

    if scrape.scrape_store.content.blank?
      response = HTTParty.get("https://#{scrape.url}")
      return Logger.error "Failed to fetch URL. HTTP Code: #{response.code}" unless response.success?
      scrape.scrape_store.update!(content: response.body)
    end

    # If the request is successful, parse the content with Nokogiri

    document = Nokogiri::HTML(scrape.scrape_store.content)

    results = []
    scrape.scrape_rules.each do |scrape_rule|
      elements = document.xpath(scrape_rule.xpath)
      elements.each_with_index do |element, index|
        results[index] ||= {}
        results[index][scrape_rule.key] = element.text.strip
      end
    end

     ScrapeResult.create!(scrape: scrape, result: results.to_json)
    scrape.update!(status: :success, last_synced_at: Time.now)
  end
end
