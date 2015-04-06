class Article < ActiveRecord::Base
    require 'net/http'
	# attr_accessor :search_date

	before_save :fetch_data

	def fetch_data
    response = Net::HTTP.get URI("http://api.nytimes.com/svc/search/v2/articlesearch.json?" + URI.encode_www_form({fq: "pub_date:(\"#{pub_date.to_date.to_s(:db)}\")", 'api-key' => Rails.application.secrets.nyt_key}))

    json = JSON.parse(response)

    # Pry.start(binding)

    article = json["response"]["docs"].sample

    self.pub_date = article["pub_date"]
    self.section_name = article["section_name"]
    self.web_url = article["web_url"]
    self.headline = article["headline"]["main"]
    self.lead_paragraph = article["lead_paragraph"]
  end
end
