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
  validates :base_health_point, presence: true
  validates :base_attack, presence: true
  validates :base_defence, presence: true
  validates :base_speed, presence: true
  validates :element_type, presence: true
  validates :image_url, presence: true
end
