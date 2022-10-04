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

  validates :name, uniqueness: true, presence: true
  validates :power, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :max_pp, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :element_type, presence: true
end
