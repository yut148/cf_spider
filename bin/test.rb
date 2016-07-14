require 'yasuri'

# "Rubyに関する新着投稿 - Qiita" を起点にする
agent = Mechanize.new
page = agent.get('http://qiita.com/tags/Ruby/items')

# 最新3ページをスクレイピングする
init_page = Yasuri.pages_init '//*[@id="main"]/div/div/div[1]/section/div[2]/ul/li[7]/a', limit:3 do

  # 現在のページ数
  text_page_idx '//*[@id="main"]/div/div/div[1]/section/div[2]/ul/li[@class="active"]/a', proc: :to_i

  # 各エントリをスクレイピング
  struct_entries '//*[@id="main"]/div/div/div[1]/section/div[1]/article' do
    text_author './div[2]/div[1]/a'
    text_date   './div[2]/div[1]/text()', truncate:/posted on (.+)/
    text_title  './div[2]/div[2]/h1/a'
    text_stock_count   './div[3]/ul/li[1]',   proc: :to_i
    text_comment_count './div[3]/ul/li[2]/a', proc: :to_i
  end
end

require 'json'
