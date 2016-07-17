require 'open-uri'
require 'nokogiri'


url = 'https://www.makuake.com/discover/projects/open/'


charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end


doc = Nokogiri::HTML.parse(html, nil, charset)

amount = 0

open_project = doc.xpath('//section[@class="projectBox"]')

open_project.each do |node, i|

  p node.css('h2').inner_text
  p node.css('dd').inner_text

  amount = amount + node.css('/div/div[1]/dl/dd').inner_text.gsub(/[^0-9]/,'').to_i


end

#1ページの支援総額
p amount
p open_project.length
