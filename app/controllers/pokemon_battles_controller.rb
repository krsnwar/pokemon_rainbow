class PokemonBattlesController < ApplicationController
  def index
    @pokemon_battles = PokemonBattle.order(:id).page params[:page]
    @current_page = params[:page].present? ? params[:page].to_i : 1
  end

  def new
    @pokemon_battle = PokemonBattle.new
    @pokemon_selection = Pokemon.all.where(id: PokemonBattle.pokemon_available_for_battle_ids)
  end

  def create
    @pokemon_battle = PokemonBattle.new(pokemon_battle_params)
    @pokemon_battle.state = PokemonBattle::ONGOING
    @pokemon_battle.pokemon1_max_health_point = @pokemon_battle.pokemon1.max_health_point
    @pokemon_battle.pokemon2_max_health_point = @pokemon_battle.pokemon2.max_health_point

    if @pokemon_battle.save
      redirect_to pokemon_battles_path, flash: { message: "Successfully created new battle" }
    else
      redirect_to new_pokemon_battle_path, flash: { message: "Battle creation failed. Pokemon cannot fight againt themselves" }
    end

  end

  def show
    @pokemon_battle = PokemonBattle.find(params[:id])
    @battle_engine = BattleEngine.new(@pokemon_battle)
    @battle_calculator = PokemonBattleCalculator.new
    @pokemon1_hp = ((@pokemon_battle.pokemon1.current_health_point/@pokemon_battle.pokemon1.max_health_point.to_f)*100).round
    @pokemon2_hp = ((@pokemon_battle.pokemon2.current_health_point/@pokemon_battle.pokemon2.max_health_point.to_f)*100).round
    
    if @battle_engine.battle_ongoing?
      @ongoing = true
    else
      @ongoing = false
    end
  end

  def update
    @battle_calculator = PokemonBattleCalculator.new
    @pokemon_battle = PokemonBattle.find(params[:id])
    skill_id = skill_chosen_params[:pokemon_skill]
    # check which turn
    if @pokemon_battle.current_turn.odd?
      # pokemon 1's turn
      attacker = @pokemon_battle.pokemon1
      defender = @pokemon_battle.pokemon2
    else
      # pokemon 2's turn
      attacker = @pokemon_battle.pokemon2
      defender = @pokemon_battle.pokemon1
    end
    
    @battle_engine = BattleEngine.new(@pokemon_battle, attacker, defender, skill_id)
    
    
    if @battle_engine.valid_next_turn?
      @battle_engine.next_turn!
      redirect_to @pokemon_battle
    else
      redirect_to @pokemon_battle, flash: { message: "Failed to go to the next turn. Either battle is stopped, pokemon died or skill unavailable." }
    end

  end

  def surrender
    @pokemon_battle = PokemonBattle.find(params[:id])
    if @pokemon_battle.current_turn.odd?
      winner = @pokemon_battle.pokemon2.name
      loser = @pokemon_battle.pokemon1.name
      @pokemon_battle.pokemon_loser_id = @pokemon_battle.pokemon1.id
      @pokemon_battle.pokemon_winner_id = @pokemon_battle.pokemon2.id
    elsif 
      winner = @pokemon_battle.pokemon1.name
      loser = @pokemon_battle.pokemon2.name
      @pokemon_battle.pokemon_loser_id = @pokemon_battle.pokemon2.id
      @pokemon_battle.pokemon_winner_id = @pokemon_battle.pokemon1.id
    end
    @pokemon_battle.state = PokemonBattle::FINISHED
    @pokemon_battle.save
    redirect_to @pokemon_battle, flash: { message: "#{loser.titleize} surrender! #{winner.titleize} is the winner" }
  end

  private
    def pokemon_battle_params
      params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id)
    end

    def skill_chosen_params
      params.require(:pokemon_battle).permit(:pokemon_skill)
    end
end
