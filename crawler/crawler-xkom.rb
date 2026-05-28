require 'nokogiri'
require 'cgi'

BASE_URL = 'https://www.x-kom.pl'

print "Wpisz czego szukasz w x-kom: "
keyword = gets.chomp

if keyword.empty?
  puts "Nie wpisano żadnego słowa kluczowego!"
  exit
end

encoded_keyword = CGI.escape(keyword)
url = "https://www.x-kom.pl/szukaj?q=#{encoded_keyword}"

puts "\nPrzeszukiwanie listy i pobieranie strony: #{url}"
html = `curl -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "#{url}"`

if html.nil? || html.empty?
  puts "Błąd: Nie udało się pobrać zawartości strony."
  exit
end

doc = Nokogiri::HTML(html)
puts "\nAnalizowanie produktów..."
count = 0

scraped_products = []

doc.css('h3').each do |h3|
  title = h3.text.strip
  next if title.empty?

  parent = h3.ancestors('div')[3]
  next unless parent

  price_match = parent.text.match(/\d+[\s\d]*,?\d*\s?zł/)
  next unless price_match
  price = price_match[0]

  link_element = parent.at_css('a')
  next unless link_element
  
  relative_link = link_element['href']
  next if relative_link.nil?

  product_url = relative_link.start_with?('http') ? relative_link : "#{BASE_URL}#{relative_link}"

  raw_specs = []

  product_html = `curl -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "#{product_url}"`

 if product_html && !product_html.empty?
    product_doc = Nokogiri::HTML(product_html)
    
    product_doc.css('div, span, li').each do |el|
      text = el.text.strip
      next unless text.include?(':')
      next if text.length > 80 

      if text.match?(/^(Seria|Wiek|Platforma|Gwarancja|Kod producenta|Rodzaj produktu|Liczba elementów|Wersja|PEGI):/)
        clean_text = text.gsub(/\s+/, ' ').strip
        next if clean_text.match?(/:$/)

        raw_specs << clean_text
      end
    end
  end

  clean_specs = raw_specs.uniq
  final_specs = []
  prefixes = []

  clean_specs.each do |spec|
    prefix = spec.split(':').first
    next if prefixes.include?(prefix) && prefix == "Platforma"
    
    final_specs << spec
    prefixes << prefix
  end

  product_data = {
    title: title,
    price: price,
    link: product_url,
    specs: final_specs
  }
  scraped_products << product_data

  puts ""
  puts "Produkt: #{product_data[:title]}"
  puts "Cena: #{product_data[:price]}"
  puts "Link: #{product_data[:link]}"
  puts "Specyfikacja:"
  
  if product_data[:specs].empty?
    puts "  - Brak szczegółowych danych technicznych"
  else
    product_data[:specs].take(5).each do |spec|
      puts "  - #{spec}"
    end
  end
  puts "-" * 50
  
  count += 1
  sleep(1)
  break if count >= 3 
end

puts "\nZawartość pamięci bota po zakończeniu pracy:"
scraped_products.each_with_index do |prod, index|
  puts "[#{index + 1}] #{prod[:title]} -> URL: #{prod[:link]}"
end