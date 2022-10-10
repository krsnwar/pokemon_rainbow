class BattleEngine

  def initialize(pokemon_battle, attacker = nil, defender = nil, skill_id = nil)
    @pokemon_battle = pokemon_battle
    if attacker.present? && defender.present? && skill_id.present?
      @attacker = attacker
      @defender = defender
      @skill_id = skill_id
      @attacker_skill_info = @attacker.pokemon_skills.find_by(skill_id: @skill_id)
    end
    @battle_calculator = PokemonBattleCalculator.new
    @pokemon_winner = nil
  end

  def valid_next_turn?
    unless pokemon_alive?
      return false
      # flash: { message: "Successfully created new battle" }
    end

    unless battle_ongoing?
      return false
      # flash: { message: "Successfully created new battle" }
    end

    unless skill_available?
      return false
      # flash: { message: "Successfully created new battle" }
    end

    return true
  end

  def next_turn!
    @damage = @battle_calculator.calculate_damage(@attacker.id, @defender.id, @skill_id)
    @defender.current_health_point -= @damage

    if defender_died?
      @defender.current_health_point = 0
      finish_battle!
      set_winner_loser!
    end

    reduce_pp!
    increase_turn!
    save!
  end

  def save!
    if @attacker_skill_info.present? && @defender.present?
      @attacker_skill_info.save
      @defender.save
    end
    if @pokemon_winner.present?
      @pokemon_winner.save
    end
    @pokemon_battle.save
  end

  def pokemon_alive?
    if @pokemon_battle.pokemon1.current_health_point.eql?(0)
      return false
    end
    if @pokemon_battle.pokemon2.current_health_point.eql?(0)
      return false
    end
    return true
  end

  def battle_ongoing?
    if @pokemon_battle.state.eql?(PokemonBattle::ONGOING)
      return true
    else
      @exp_gained = @battle_calculator.calculate_experience(@pokemon_battle.pokemon_loser.level)
      if @pokemon_battle.experience_gain.nil?
        @pokemon_winner = @pokemon_battle.pokemon_winner
        @pokemon_battle.experience_gain = @exp_gained
        @pokemon_winner.current_experience += @exp_gained

        while @battle_calculator.level_up?(@pokemon_winner.level, @pokemon_winner.current_experience) do
          extra_stats = @battle_calculator.calculate_level_up_extra_stats
          @pokemon_winner.level += 1
          @pokemon_winner.max_health_point += extra_stats.max_health_point
          @pokemon_winner.attack += extra_stats.attack
          @pokemon_winner.defence += extra_stats.defence
          @pokemon_winner.speed += extra_stats.speed
        end

        save!
      end
      return false
    end
  end

  def skill_available?
    if @attacker_skill_info.present? && @attacker_skill_info.current_pp > 0
      return true
    else
      return false
    end
  end

  def defender_died?
    if @defender.current_health_point <= 0
      return true
    else
      return false
    end
  end

  def finish_battle!
    @pokemon_battle.state = PokemonBattle::FINISHED
  end

  def set_winner_loser!
    @pokemon_battle.pokemon_winner_id = @attacker.id
    @pokemon_battle.pokemon_loser_id = @defender.id
  end

  def reduce_pp!
    @attacker_skill_info.current_pp -= 1
  end

  def increase_turn!
    @pokemon_battle.current_turn += 1
  end

end