class ChangePokemonLoserWinnerNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :pokemon_battles, :pokemon_winner_id, true
    change_column_null :pokemon_battles, :pokemon_loser_id, true
  end
end
