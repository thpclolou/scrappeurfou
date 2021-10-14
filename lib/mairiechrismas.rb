require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'restclient'

# get_townhall_valdoise_url vas chercher TOUS les urls de toutes les mairies du val d'oise
def get_townhall_valdoise_url
    townhall_link = "http://annuaire-des-mairies.com/val-d-oise.html"
    townhallurls = Array.new
    page = Nokogiri::HTML(URI.open(townhall_link))
    geturl = page.css('//[@class="lientxt"]').each do |link|
        url = link['href']
        townhallurls << url
    end
    return townhallurls
end

# get_townhall_email recupere les emails de chaques site de chaques marie via les urls récupérés plus haut
def get_townhall_email(url)
    url1 = "https://www.annuaire-des-mairies.com/"
        emails = Array.new
        page = Nokogiri::HTML(URI.open(url1 + url)) # ici on ajoute a l'url source l'extension correspondant a chacunes des villes
        page.xpath('//td[contains(text(), "@")]').each do |links|
            emails.push(links.text)
        end
    return emails
end

# finalement get_townhall_names vas trouver et mettre dans un tableau tous les nom des villes de tout le val d'oise
def get_townhall_names
    townhall_link = "http://annuaire-des-mairies.com/val-d-oise.html"
    names = Array.new
    name = Nokogiri::HTML(URI.open(townhall_link))
    name.xpath('//a[contains(@href, "95")]').each do |n|
        names.push(n.text)
    end
    return names
end

# perform execute et affiche l'ensemble du programme
def perform()
    hyp = get_townhall_valdoise_url
    city = get_townhall_names
    i = 0
    j = 0
    while i < get_townhall_valdoise_url.length
        puts "==============================================================="
        print city[j]
        print "  =>  "
        puts get_townhall_email(hyp[j])
        puts "==============================================================="
        i = i + 1
        j = j + 1
    end
end

perform
