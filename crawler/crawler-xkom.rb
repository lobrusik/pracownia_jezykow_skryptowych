require 'nokogiri'
url = 'https://www.x-kom.pl/g-64/c/2073-klocki-lego.html'

puts "Pobieranie strony..."
html = `curl -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "#{url}"`

if html.nil? || html.empty?
  puts "Błąd: Nie udało się pobrać zawartości strony."
  exit
end

doc = Nokogiri::HTML(html)

puts "\nZnalezione produkty:"
count = 0

doc.css('h3').each do |h3|
  title = h3.text.strip
  next if title.empty?

  parent = h3.ancestors('div')[3]
  next unless parent

  price_match = parent.text.match(/\d+[\s\d]*,?\d*\s?zł/)
  next unless price_match
  
  price = price_match[0]

  puts "Produkt: #{title}"
  puts "Cena:    #{price}"
  puts "-" * 40
  count += 1
end

puts "Koniec. Znaleziono #{count} produnktów."