class PokemonBattle < ApplicationRecord
  after_initialize do
    self.current_turn ||= 1
  end

  ONGOING = "ongoing"
  FINISHED = "finished"

  STATE = [
    ONGOING,
    FINISHED
  ]

  belongs_to :pokemon1, :class_name => "Pokemon"
  belongs_to :pokemon2, :class_name => "Pokemon"
  belongs_to :pokemon_winner, optional: true, :class_name => "Pokemon"
  belongs_to :pokemon_loser, optional: true, :class_name => "Pokemon"

  validates :pokemon2, comparison: { other_than: :pokemon1 }
  validates :state, inclusion: { in: STATE,  message: "%{value} is not valid element type" }

  def self.pokemon_available_for_battle_ids
    all_pokemon_ids = Pokemon.all.ids
    pokemon_died = Pokemon.all.where(current_health_point: 0).ids
    pokemon_ongoing = PokemonBattle.all.where(state: "ongoing").map { |row| row.pokemon1_id }
    pokemon_ongoing += PokemonBattle.all.where(state: "ongoing").map { |row| row.pokemon2_id }

    pokemon_available = all_pokemon_ids - pokemon_died - pokemon_ongoing
    pokemon_available
  end

end
