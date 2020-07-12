SitemapGenerator::Sitemap.default_host = "https://torntrader.com"
SitemapGenerator::Sitemap.ping_search_engines('https://torntrader.com/sitemap.xml.gz')

SitemapGenerator::Sitemap.create do
  add '/contact'
  
  User.find_each do |user|
    next unless user.price_list
    add price_list_path(user), lastmod: user.updated_at
  end
end
