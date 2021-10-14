require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'restclient'

# définir une méthode qui vas scrapper les noms des députés

def get_dep_name
    dep_name = Array.new
    page = Nokogiri::HTML(URI.open('https://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
    page.xpath('//a[contains(@href, "deput")]').each do |dep|
        dep_name.push(dep.text)
    end
    return dep_name
end

def perform
    i = 0
    j = 3
    while i < get_dep_name.length
        puts "Député-----------------------"
        puts i
        puts get_dep_name[j]
        puts ""
        i = i + 1
        j = j + 1
    end
end

perform
