require 'nokogiri'
require 'open-uri'

# Récupère l'e-mail d'une mairie à partir de son URL
def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  email = page.xpath('//section[2]/div/table/tbody/tr[4]/td[2]').text
  return email
end

# Récupère les URLs de chaque ville du Val d'Oise
def get_townhall_urls
  page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  urls = page.xpath('//a[@class="lientxt"]/@href')
  urls = urls.map { |url| "https://www.annuaire-des-mairies.com" + url.text[1..-1] }
  return urls
end

# Crée un array de hash contenant les e-mails de chaque mairie du Val d'Oise
def get_townhall_emails
  urls = get_townhall_urls
  emails = []
  urls.each do |url|
    name = Nokogiri::HTML(URI.open(url)).xpath('//section[1]/div/div/div/h1').text.gsub(" - ", "")
    email = get_townhall_email(url)
    emails << { name => email }
  end
  return emails
end

# Affiche le résultat
puts get_townhall_emails


# TRAVAILLE DE LILIAN

# require 'nokogiri'
# require 'open-uri'

# def get_ville

#   region_page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

#   return ville_name_array = region_page.xpath("//a[contains(@class, 'lientxt')]/text()").map {|x| x.to_s.downcase.gsub(" ", "-") }

# end

# def get_email (ville_names)

#   ville_email_array = []

#   # Boucle sur chaque ville du tableau pour obtenir l'e-mail
#   for n in 0...ville_names.length

#     ville_page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/95/#{ville_names[n]}.html"))

#     ville_email_array << ville_page.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").to_s

#   end

#   return ville_email_array
# end

# puts email_ville_result = Hash[get_ville.zip(get_email(get_ville))]