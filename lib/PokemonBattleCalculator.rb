class PokemonBattleCalculator

  def initialize
    @element_type = [
      "normal",
      "fighting",
      "flying",
      "poison",
      "ground",
      "rock",
      "bug",
      "ghost",
      "steel",
      "fire",
      "water",
      "grass",
      "electric",
      "psychic",
      "ice",
      "dragon",
      "dark",
      "fairy"
    ]

    @resistance = [
      [1, 1, 1, 1, 1, 0.5, 1, 0, 0.5, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [2, 1, 0.5, 0.5, 1, 2, 0.5, 0, 2, 1, 1, 1, 1, 0.5, 2, 1, 2, 0.5],
      [1, 2, 1, 1, 1, 0.5, 2,	1, 0.5,	1, 1, 2, 0.5, 1, 1, 1, 1, 1],
      [1, 1, 1, 0.5, 0.5, 0.5, 1, 0.5, 0, 1, 1, 2, 1, 1, 1, 1, 1, 2],
      [1, 1, 0, 2, 1, 2, 0.5, 1, 2, 2, 1, 0.5, 2, 1, 1, 1, 1, 1],
      [1, 0,5, 2, 1, 0.5, 1, 2, 1, 0.5, 2, 1, 1, 1, 1, 2, 1, 1, 1],
      [1, 0.5, 0.5, 0.5, 1, 1, 1, 0.5, 0.5, 0.5, 1, 2, 1, 2, 1, 1, 2, 0.5],
      [0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 0.5, 1],
      [1, 1, 1, 1, 1, 2, 1, 1, 0.5, 0.5, 0.5, 1, 0.5, 1, 2, 1, 1, 2],
      [1, 1, 1, 1, 1, 0.5, 2, 1, 2, 0.5, 0.5, 2, 1, 1, 2, 0.5, 1, 1],
      [1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 0.5, 0.5, 1, 1, 1, 0.5, 1, 1],
      [1, 1, 0.5, 0.5, 2, 2, 0.5, 1, 0.5, 0.5, 2, 0.5, 1, 1, 1, 0.5, 1, 1],
      [1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 2, 0.5, 0.5, 1, 1, 0.5, 1, 1],
      [1, 2, 1, 2, 1, 1, 1, 1, 0.5, 1, 1, 1, 1, 0.5, 1, 1, 0, 1],
      [1, 1, 2, 1, 2, 1, 1, 1, 0.5, 0.5, 0.5, 2, 1, 1, 0.5, 2, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 0.5, 1, 1, 1, 1, 1, 1, 2, 1, 0],
      [1, 0.5, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 0.5, 0.5],
      [1, 2, 1, 0.5, 1, 1, 1, 1, 0.5, 0.5, 1, 1, 1, 1, 1, 2, 2, 1]
    ]
  end

  def calculate_damage(attacker, defender, skill)
    pokemon_attacker = Pokemon.find(attacker)
    pokemon_defender = Pokemon.find(defender)
    skill = Skill.find(skill)
    puts "before stab"
    stab = (pokemon_attacker.pokedex.element_type == pokemon_defender.pokedex.element_type) ? 1.5 : 1
    resistance = @resistance[@element_type.find_index(pokemon_attacker.pokedex.element_type)][@element_type.find_index(pokemon_defender.pokedex.element_type)]

    damage = ((((2 * pokemon_attacker.level / 5.0 + 2) * pokemon_attacker.attack * skill.power / pokemon_defender.defence) / 50.0) + 2) * stab * resistance * (rand(85..100) / 100.0)
    damage.round
  end

  def calculate_experience(enemy_level)
    exp_gain = rand(20..150) * enemy_level
    exp_gain
  end

  def level_up?(level_winner, total_exp_winner)
    exp_threshold = (2 ** level_winner) * 100
    if total_exp_winner >= exp_threshold
      leveling_up = true
    else
      leveling_up = false
    end
    leveling_up
  end

  Extra_stats = Struct.new(:max_health_point, :attack, :defence, :speed)
  def calculate_level_up_extra_stats

    extra_stats = Extra_stats.new(rand(10..20), rand(1..5), rand(1..5), rand(1..5))

    extra_stats
  end

  def health_background(hp)
    if hp > 75
      background = "bg-success"
    elsif hp < 25
      background = "bg-danger"
    else
      background = "bg-warning"
    end
    background
  end
end