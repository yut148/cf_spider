require 'open-uri'
require 'nokogiri'

url = 'https://www.makuake.com/discover/projects/open/'


charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end


doc = Nokogiri::HTML.parse(html, nil, charset)
# page_num = doc.xpath('//li[@class="interval"]/a').inner_text.to_i
page_num = doc.xpath('//*[@id="projectDetails"]/div[3]/ul/li[11]/a').attribute('href').value.gsub(/[^0-9]/,'').to_i
amount = 0
total_amount = 0
total_open_project = 0

1.upto(page_num) do |page|
doc = Nokogiri::HTML(open("https://www.makuake.com/discover/projects/open/#{page}/"))

open_project = doc.xpath('//section[@class="projectBox"]')

  open_project.each do |node, i|

    p node.css('h2').inner_text
    p node.css('dd').inner_text
    puts ""

    amount = amount + node.css('/div/div[1]/dl/dd').inner_text.gsub(/[^0-9]/,'').to_i

  end

  @total_amount = total_amount + amount
  total_open_project = total_open_project + open_project.length
end

puts "Makuakeの#{Time.now}時点の公開プロジェクト"
p "合計#{total_open_project}プロジェクト 支援総額#{@total_amount}円"
