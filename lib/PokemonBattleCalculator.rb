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
    # Damage = ((((2 * Level pokemon / 5 + 2) * Attack pokemon * SkillPower move / Defense enemy pokemon) / 50) + 2) * STAB * Weakness/Resistance * (RandomNumber / 100)
    damage.round
  end
end