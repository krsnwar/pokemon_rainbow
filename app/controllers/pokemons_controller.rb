class PokemonsController < ApplicationController

  def index
    if params[:search].present?
      @pokemons = Pokemon.where("pokemons.name LIKE ?", "%#{params[:search]}%")
      @pokemons = @pokemons.page (params[:page])
    else
      @pokemons = Pokemon.order(:id).page params[:page]
    end
    @current_page = params[:page].present? ? params[:page].to_i : 1
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    pokedex_info = Pokedex.find(pokemon_params[:pokedex_id])
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.max_health_point = pokedex_info.base_health_point
    @pokemon.current_health_point = pokedex_info.base_health_point
    @pokemon.attack = pokedex_info.base_attack
    @pokemon.defence = pokedex_info.base_defence
    @pokemon.speed = pokedex_info.base_speed
    
    if @pokemon.valid? && @pokemon.save
      redirect_to @pokemon, flash: { message: "Successfully created pokemon: #{@pokemon.name.titleize}" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  def update
    @pokemon = Pokemon.find(params[:id])

    if @pokemon.update(pokemon_params)
      redirect_to @pokemon, flash: { message: "Pokemon has successfully been edited" }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    pokemon_name = @pokemon.name
    @pokemon.destroy

    redirect_to pokemons_path, flash: { message: "Pokemon #{pokemon_name.titleize} has successfully been deleted" }, status: :see_other
  end

  private
    def pokemon_params
      params.require(:pokemon).permit(:name, :pokedex_id)
    end

end