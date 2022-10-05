class Pokemon < ApplicationRecord
  after_initialize do
    self.level ||= 1
    self.current_experience ||= 0
  end

  belongs_to :pokedex

  validates :name, uniqueness: true, presence: true
  validates :level, presence: true, numericality: { only_integer: true }
  validates :max_health_point, presence: true, numericality: { only_integer: true }
  validates :current_health_point, presence: true, numericality: { only_integer: true }
  validates :attack, presence: true, numericality: { only_integer: true }
  validates :defence, presence: true, numericality: { only_integer: true }
  validates :speed, presence: true, numericality: { only_integer: true }
  validates :current_experience, presence: true, numericality: { only_integer: true }
end
