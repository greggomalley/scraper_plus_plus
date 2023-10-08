class ScrapeJob
  include Sidekiq::Job

  def perform(scrape_ref)
    scrape = Scrape.find_by(ref: scrape_ref)
    return unless scrape

    response = HTTParty.get(scrape.url)

    # If the request is successful, parse the content with Nokogiri
    return Logger.error "Failed to fetch URL. HTTP Code: #{response.code}" unless response.success?

    document = Nokogiri::HTML(response.body)

    # For the sake of simplicity at the moment we'll just assume one rule per scrape.
    result = {}
    scrape.scrape_rules.each do |scrape_rule|
      elements = document.xpath(scrape_rule.xpath)
      if elements.length > 1

      end
      elements.each do |element|
        puts element.text.strip
      end
      result[scrape_rule.key] = element.text.strip
    end
  end
end
