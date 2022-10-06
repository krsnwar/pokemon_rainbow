class CreatePokemonBattles < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_battles do |t|
      t.references :pokemon1, null: false
      t.references :pokemon2, null: false
      t.integer :current_turn
      t.string :state
      t.references :pokemon_winner, null: false
      t.references :pokemon_loser, null: false
      t.integer :experience_gain
      t.integer :pokemon1_max_health_point
      t.integer :pokemon2_max_health_point

      t.timestamps
    end
  end
end
