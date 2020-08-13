class Ingredient < ApplicationRecord
  has_many :doses
  before_destroy :check_for_doses
  validates :name, uniqueness: true, presence: true

  def check_for_doses
    if doses.count > 0
      raise ActiveRecord::InvalidForeignKey
    end
  end
end
