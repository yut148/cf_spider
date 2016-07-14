require 'open-uri'
require 'nokogiri'

page = [1...16]
url = 'https://www.makuake.com/discover/projects/open/'



charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end


doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//section[@class="projectBox"]').each do |node|

  p node.css('h2').inner_text
  p node.css('dd').inner_text


  # p node.css('img').attribute('src').value

  # p node.css('a').attribute('href').value
end
