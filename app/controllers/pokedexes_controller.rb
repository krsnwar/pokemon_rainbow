require 'pry'

class PokedexesController < ApplicationController

  def index
    if params[:search].present?
      @search_name = params[:search]
      @pokedexes = Pokedex.where("pokedexes.name LIKE ?", "%#{@search_name}%")
      @pokedexes = @pokedexes.order(:name).page (params[:page])
    else
      @pokedexes = Pokedex.order(:name).page params[:page]
    end
    @current_page = params[:page].present? ? params[:page].to_i : 1
  end
  
  def show
    @pokedex = Pokedex.find(params[:id])
  end

  def new
    @pokedex = Pokedex.new
  end

  def create
    @pokedex = Pokedex.new(pokedex_params)
    
    if @pokedex.valid? && @pokedex.save
      redirect_to @pokedex, flash: { message: "Successfully created pokedex: #{@pokedex.name.titleize}" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pokedex = Pokedex.find(params[:id])
  end

  def update
    @pokedex = Pokedex.find(params[:id])

    if @pokedex.update(pokedex_params)
      redirect_to @pokedex, flash: { message: "Pokedex has successfully been edited" }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pokedex = Pokedex.find(params[:id])
    pokedex_name = @pokedex.name
    @pokedex.destroy

    redirect_to pokedexes_path, flash: { message: "Pokedex #{pokedex_name.titleize} has successfully been deleted" }, status: :see_other
  end

  private
    def pokedex_params
      params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url)
    end

end
