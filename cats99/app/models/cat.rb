
class Cat < ApplicationRecord
  validates :birth_date, presence: true
  validates :name, presence: true
  validates :color, presence: true
  validates :sex, presence: true
  validates :description, presence: true

  has_many :rental_requests,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest

  def age
    Time.now.year - self.birth_date.year
  end
  
end