# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

brands = [
  ["Oscha", "http://www.oschaslings.com/"],
  ["Dydimos", "http://www.dydimos.de/"],
  ["Natibaby", "http://www.natibaby.eu/"],
  ["Girasol", "http://www.girasol.de/"],
  ["Yaro", "https://www.facebook.com/pages/Yaro-Slings/742101595804901"],
  ["Little Frog", "http://littlefrog.pl/"],
  ["Lenny Lamb", "http://en.lennylamb.com/"],
  ["Pavo", "http://pavotextiles.com/"],
  ["Cari Slings", "http://www.carislings.com/"],
  ["Danu", "http://www.danuworld.com/"],
  ["Shire Slings", "http://shireslings.co.uk/"],
  ["Fire Spiral", "http://www.firespiralslings.co.uk/"],
  ["Baie", "http://www.baieslings.com/"],
  ["Hoppediz", "http://www.hoppediz.de/en/"],
  ["Amazonas", "http://www.amazonas.eu/en/"],
  ["Kokadi", "http://www.kokadi.de/"],
  ["Linushka", "http://www.linuschka.de/"],
  ["Ellevil", "http://www.ellevill.com/"],
]

brand_map  = brands.map { |b| Hash[[:name, :website].zip(b)]}
Brand.create(brand_map)
