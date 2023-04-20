require 'nokogiri'
require 'open-uri'

# Méthode qui récupère l'e-mail d'une mairie à partir de son URL
def get_townhall_email(townhall_url)
  # Parsing de la page de la mairie avec Nokogiri
  doc = Nokogiri::HTML(open(townhall_url))

  # Recherche de l'e-mail de la mairie dans le contenu de la page
  email = doc.xpath("//section[2]/div/table/tbody/tr[4]/td[2]").text.strip

  # Retourne l'e-mail trouvé
  return email
end

# Méthode qui récupère les URLs de toutes les mairies du Val d'Oise
def get_townhall_urls
  # URL de l'annuaire des mairies du Val d'Oise
  url = "http://annuaire-des-mairies.com/val-d-oise.html"

  # Parsing de la page de l'annuaire avec Nokogiri
  doc = Nokogiri::HTML(open(url))

  # Recherche des liens des mairies dans le contenu de la page
  links = doc.xpath("//a[@class='lientxt']")

  # Création d'un array pour stocker les URLs des mairies
  urls = []

  # Parcours des liens trouvés et récupération de l'URL de chaque mairie
  links.each do |link|
    # Récupération de l'URL de la mairie
    townhall_url = "http://annuaire-des-mairies.com" + link['href'][1..-1]

    # Ajout de l'URL à l'array
    urls << townhall_url
  end

  # Retourne l'array d'URLs de mairies
  return urls
end

# Méthode qui récupère les adresses e-mail de toutes les mairies du Val d'Oise
def get_townhall_emails
  # Récupération des URLs des mairies
  urls = get_townhall_urls

  # Création d'un array pour stocker les adresses e-mail des mairies
  emails = []

  # Parcours des URLs des mairies et récupération de l'adresse e-mail de chaque mairie
  urls.each do |url|
    # Récupération de l'adresse e-mail de la mairie
    email = get_townhall_email(url)

    # Récupération du nom de la ville à partir de l'URL
    town_name = url.split("/")[-1].split(".")[0].capitalize.gsub("-", " ")

    # Création d'un hash pour stocker le nom de la ville et son adresse e-mail
    town_hash = { town_name => email }

    # Ajout du hash à l'array des adresses e-mail
    emails << town_hash
  end

  # Retourne l'array des adresses e-mail des mairies
  return emails
end

# Affichage des adresses e-mail des mairies
puts get_townhall_emails
