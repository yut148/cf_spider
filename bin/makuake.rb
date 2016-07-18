require 'open-uri'
require 'nokogiri'

url = 'https://camp-fire.jp/projects/fresh'


charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end


doc = Nokogiri::HTML.parse(html, nil, charset)

# 公開のプロジェクトをどこまでクロールすればいいのか目視しないといけない
page_num = 25
amount = 0
total_amount = 0
total_open_project = 0
project_counter = 0
green_card = 0

1.upto(page_num) do |page|
doc = Nokogiri::HTML(open("https://camp-fire.jp/projects/fresh/page:#{page}"))

open_project = doc.xpath('//section[@class="fresh"]/div/div[2]/div')


  open_project.each do |node, i|

    # unless node.xpath("//div[@class='box-customed-overview']")
    #   next;
    # end

    if node.css('div/div[5]/div[3]/text()').inner_text == '終了' || node.css('div/div[5]/div[3]/text()').inner_text.empty? then
      next;
    end

    p node.css('h4').inner_text

    p node.css('div/div[5]/div[1]').inner_text
    p node.css('div/div[5]/div[2]').inner_text
    amount = amount + node.css('div/div[5]/div[1]').inner_text.gsub(/[^0-9]/,'').to_i
    project_counter = project_counter + 1


  end

  @total_amount = total_amount + amount
  @total_open_project = total_open_project + project_counter
end

puts "Campfireの#{Time.now}時点の公開プロジェクト"
p "合計#{@total_open_project}プロジェクト 支援総額#{@total_amount}円"
