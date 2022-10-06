class PokemonBattle < ApplicationRecord
  after_initialize do
    self.current_turn ||= 1
  end

  STATE = [
    "ongoing",
    "finished"
  ]

  belongs_to :pokemon1, :class_name => "Pokemon"
  belongs_to :pokemon2, :class_name => "Pokemon"
  belongs_to :pokemon_winner, optional: true, :class_name => "Pokemon"
  belongs_to :pokemon_loser, optional: true, :class_name => "Pokemon"
  has_many :pokemons

  validates :pokemon2, comparison: { other_than: :pokemon1 }
end
