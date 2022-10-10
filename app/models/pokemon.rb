class Pokemon < ApplicationRecord
  after_initialize do
    self.level ||= 1
    self.current_experience ||= 0
  end

  belongs_to :pokedex
  has_many :pokemon_skills
  has_many :skills, through: :pokemon_skills, source: :skill, dependent: :delete_all
  has_many :pokemon_battles

  validates :name, uniqueness: true, presence: true
  validates :level, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :max_health_point, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :current_health_point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: :max_health_point }
  validates :attack, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :defence, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :speed, presence: true, numericality: { only_integer: true, grater_than: 0 }
  validates :current_experience, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # accept nested attributes pokemon skills (composite)

end
