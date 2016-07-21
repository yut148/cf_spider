require 'open-uri'
require 'nokogiri'

url = 'https://camp-fire.jp/projects/view/1206'

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

amount = 0
total_amount = 0
total_open_project = 0

doc = Nokogiri::HTML.parse(html, nil, charset)
9001.upto(10000) do |page|
  begin
      doc = Nokogiri::HTML(open("https://camp-fire.jp/projects/view/#{page}/"))
    rescue OpenURI::HTTPError
      sleep 2
      next
    end

  open_project = doc.xpath('//section[@class="header-in"]')
    open_project.each do |node, i|


      p node.css('h1').inner_text
      p "https://camp-fire.jp/projects/view/#{page}"
      p node.xpath('//*[@id="js-container"]/div/aside/section[1]/div[2]/a').inner_text
      p "https://camp-fire.jp#{node.xpath('//*[@id="js-container"]/div/aside/section[1]/div[2]/a')[0]['href']}"

      if node.xpath('section[2]/div[2]/section[1]/div[2]/div[2]/text()').inner_text.gsub(/[^0-9]/,'').to_i == 0
          p node.xpath('section[2]/div[2]/section[2]/p/text()[1]').inner_text.gsub(/[^0-9]/,'').to_i
          p node.xpath('section[2]/div[2]/section[2]/p/text()[2]').inner_text.gsub(/[^0-9]/,'').to_i
        else
          p node.xpath('section[2]/div[2]/section[1]/div[2]/div[2]/text()').inner_text.gsub(/[^0-9]/,'').to_i
          p node.css('section[2]/div[2]/section[1]/div[2]/strong').inner_text.gsub(/[^0-9]/,'').to_i
      end

      p node.css('section[1]/div/ul/li/a').inner_text
      p node.xpath('section[2]/div[1]/section[2]/div/ul[1]/li[2]/a').inner_text.delete('#')
      p node.css('section[2]/div[2]/section[1]/div[3]/strong').inner_text
      p node.css('section[2]/div[2]/section[1]/div[4]/strong').inner_text
      p node.css('section[2]/div[2]/section[2]/p/strong[1]').inner_text.delete('に')
      p node.css('section[2]/div[2]/section[2]/p/strong[4]').inner_text
      p node.css('section[2]/div[2]/section[2]/p/strong[3]').inner_text

      amount = amount + node.css('section[2]/div[2]/section[1]/div[2]/strong').inner_text.gsub(/[^0-9]/,'').to_i

      File.open('campfire_all.txt', 'a') do |file|
        file.puts node.css('h1').inner_text
        file.puts "https://camp-fire.jp/projects/view/#{page}"
        file.puts node.xpath('//*[@id="js-container"]/div/aside/section[1]/div[2]/a').inner_text
        file.puts "https://camp-fire.jp#{node.xpath('//*[@id="js-container"]/div/aside/section[1]/div[2]/a')[0]['href']}"

        if node.xpath('section[2]/div[2]/section[1]/div[2]/div[2]/text()').inner_text.gsub(/[^0-9]/,'').to_i == 0
            file.puts node.xpath('section[2]/div[2]/section[2]/p/text()[1]').inner_text.gsub(/[^0-9]/,'').to_i
            file.puts node.xpath('section[2]/div[2]/section[2]/p/text()[2]').inner_text.gsub(/[^0-9]/,'').to_i
          else
            file.puts node.xpath('section[2]/div[2]/section[1]/div[2]/div[2]/text()').inner_text.gsub(/[^0-9]/,'').to_i
            file.puts node.css('section[2]/div[2]/section[1]/div[2]/strong').inner_text.gsub(/[^0-9]/,'').to_i
        end

        file.puts node.css('section[1]/div/ul/li/a').inner_text
        file.puts node.xpath('section[2]/div[1]/section[2]/div/ul[1]/li[2]/a').inner_text.delete('#')
        file.puts node.css('section[2]/div[2]/section[1]/div[3]/strong').inner_text
        file.puts node.css('section[2]/div[2]/section[1]/div[4]/strong').inner_text
        file.puts node.css('section[2]/div[2]/section[2]/p/strong[1]').inner_text.delete('に')
        file.puts node.css('section[2]/div[2]/section[2]/p/strong[4]').inner_text
        file.puts node.css('section[2]/div[2]/section[2]/p/strong[3]').inner_text
      end


    end
    @total_amount = total_amount + amount
    total_open_project = total_open_project + open_project.length
    p "現在#{total_open_project}"

end


puts "Campfireの#{Time.now}時点の全プロジェクト"
p "合計#{total_open_project}プロジェクト 支援総額#{@total_amount}円"
