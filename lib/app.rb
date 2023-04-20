require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))



array_name = []

page.xpath(('//tbody/tr/td/div/a[@class="cmc-table__column-name--name cmc-link"]')).each do |crypto_name|
    array_name << crypto_name.text
end

#puts array_name.inspect


array_value = []

page.xpath(('//tbody/tr/td/p/span[@class="sc-edc9a476-0 fXzXSk"]')).each do |crypto_value|
    array_value << crypto_value.text
end

#puts array_value.inspect

def fusion(array_name, array_value)
    attachement = [array_name , array_value].transpose
    hash = Array.new 
    hash << attachement.to_h
    puts hash.inspect
end

fusion(array_name,array_value)



