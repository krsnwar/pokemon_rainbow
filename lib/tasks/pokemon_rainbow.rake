require 'csv'
require 'open-uri'

namespace :pokemon_rainbow do
  desc "TODO"
  task import_pokedex: :environment do
    csv_text = File.read(URI.open('https://docs.google.com/spreadsheets/d/e/2PACX-1vR8lP2c677HFJ7agTrXdzbTAAjHQlmPieKf8q3ao6crvSQ5-JhxJ_tQqDu0aSVERhbz6hZYvkdiatH3/pub?gid=386832440&single=true&output=csv'))
    csv_text = CSV.parse(csv_text)
    keys = csv_text.shift
    csv_text.map! { |row| Hash[keys.zip(row)] }

    csv_text.each do |pokedex_attrib|
      pokedex = Pokedex.new(pokedex_attrib)
      pokedex.save
    end
  end

end
