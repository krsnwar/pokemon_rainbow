class Pokedex < ApplicationRecord

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
  validates :base_health_point, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :base_attack, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :base_defence, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :base_speed, presence: true,  numericality: { only_integer: true, grater_than: 0 }
  validates :element_type, presence: true, inclusion: { in: ELEMENT_TYPES,  message: "%{value} is not valid element type"}
  validates :image_url, presence: true
end
