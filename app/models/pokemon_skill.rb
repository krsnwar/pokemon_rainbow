class PokemonSkill < ApplicationRecord
  after_initialize do
    self.current_pp ||= 0
  end

  belongs_to :skill
  belongs_to :pokemon

  validates :current_pp, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
