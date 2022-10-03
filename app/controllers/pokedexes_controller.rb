class PokedexesController < ApplicationController

  def index
    @pokedexes = Pokedex.all
  end

  def new
    @pokedex = Pokedex.new
    @element_type = [["Normal", "normal"], ["Fighting", "fighting"], ["Flying", "flying"], ["Poison", "poison"], ["Ground", "ground"], ["Rock", "rock"], ["Bug", "bug"], ["Ghost", "ghost"], ["Steel", "steel"], ["Fire", "fire"], ["Water", "water"], ["Grass", "grass"], ["Electric", "electric"], ["Psychic", "psychic"], ["Ice", "ice"], ["Dragon", "dragon"], ["Dark", "dark"], ["Fairy", "fairy"]]
  end

  def create
    @pokedex = Pokedex.new(pokedex_params)

  end

  def show
    @pokedex = Pokedex.find(params[:id])
  end

  private
    def pokedex_params
      params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url)
    end

end
