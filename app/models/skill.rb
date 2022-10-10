class Skill < ApplicationRecord

  ELEMENT_TYPES = [
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

  has_many :pokemon_skills
  has_many :pokemon_used, through: :pokemon_skills, source: :pokemon

  validates :name, uniqueness: true, presence: true
  validates :power, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :max_pp, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :element_type, presence: true, inclusion: { in: ELEMENT_TYPES,  message: "%{value} is not valid element type"}
end
