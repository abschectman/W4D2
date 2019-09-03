class CatRentalRequest < ApplicationRecord
  validates :status, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :cat_id, presence: true
  validate :does_not_overlap_approved_requests


  belongs_to :cat,
    foreign_key: :cat_id,
    class_name: :Cat,
    dependent: :destroy

  def overlapping_requests
    CatRentalRequest.where("cat_rental_requests.cat_id = cat_id")
    .where.not("start_date > cat_rental_requests.end_date AND end_date < cat_rental_requests.start_date")
  end

  def overlapping_approved_requests
    overlapping_requests.where("cat_rental_requests.status = 'APPROVED'")
  end

  def does_not_overlap_approved_requests
    if overlapping_approved_requests.exists?
      errors[:cat_id] << 'Overlapping schedule'
    end
  end
end