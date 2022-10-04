require 'pry'

class PokedexesController < ApplicationController

  def index
    @pokedexes = Pokedex.order(:id).page params[:page]
    @current_page = params[:page].present? ? params[:page].to_i : 1
  end

  def new
    @pokedex = Pokedex.new
  end

  def create
    @pokedex = Pokedex.new(pokedex_params)
    
    if @pokedex.valid? && @pokedex.save
      redirect_to @pokedex, flash: { success: "Pokedex has successfully been created" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @pokedex = Pokedex.find(params[:id])
  end

  private
    def pokedex_params
      params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url)
    end

end
