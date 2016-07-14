require 'yasuri'

# "Rubyに関する新着投稿 - Qiita" を起点にする
agent = Mechanize.new
page = agent.get('https://www.makuake.com/discover/projects/open/')

# 最新3ページをスクレイピングする
init_page = Yasuri.pages_init '//section[@class="projectBox"]' do

  # 現在のページ数
  text_page_idx '//*[@class="pageStay"]/a', proc: :to_i

  # 各エントリをスクレイピング
  struct_entries '//section[@class="projectBox"]' do
    p node.css'h2').inner_text


  end
end
