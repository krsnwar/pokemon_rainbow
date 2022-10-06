class PokemonBattlesController < ApplicationController
  def index
    # if params[:search].present?
    #   @search_name = params[:search]
    #   @pokemons = Pokemon.where("LOWER(pokemons.name) LIKE ?", "%#{@search_name}%")
    #   @pokemons = @pokemons.page (params[:page])
    # else
    @pokemon_battles = PokemonBattle.order(:id).page params[:page]
    # end
    @current_page = params[:page].present? ? params[:page].to_i : 1
  end

  def new
    @pokemon_battle = PokemonBattle.new
  end

  def create
    @pokemon_battle = PokemonBattle.new(pokemon_battle_params)
    @pokemon_battle.state = PokemonBattle::STATE[0]
    @pokemon_battle.pokemon1_max_health_point = @pokemon_battle.pokemon1.max_health_point
    @pokemon_battle.pokemon2_max_health_point = @pokemon_battle.pokemon2.max_health_point

    if @pokemon_battle.save
      redirect_to pokemon_battles_path, flash: { message: "Successfully created new battle" }
    else
      redirect_to new_pokemon_battle_path, flash: { message: "Battle creation failed" }
    end

  end

  def show
    @pokemon_battle = PokemonBattle.find(params[:id])
  end

  private
    def pokemon_battle_params
      params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id)
    end
end
