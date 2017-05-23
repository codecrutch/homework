class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
            message: "%{value} is not a valid status" }
  validate :does_not_overlap_approved_request
  validate :start_date_earlier_than_end_date

  belongs_to :cat,
    class_name: :Cat,
    primary_key: :id,
    foreign_key: :cat_id

  def approve!
    transaction do
      unless overlapping_approved_requests.exists?
        self.status = "APPROVED"
        overlapping_pending_requests.each do |request|
          request.deny!
        end
      else
        self.status = "DENIED"
      end

      save
    end
  end

  def deny!
    self.status = "DENIED"
    save
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_requests
      CatRentalRequest
        .where.not(id: self.id)
        .where("cat_id = ?", cat_id)
        .where.not("end_date < ? OR start_date > ?", start_date, end_date)
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors[:base] << "Overlaps with approved requests"
    end
  end

  def start_date_earlier_than_end_date
    unless start_date < end_date
      errors[:base] << "Start date must be before end date!"
    end
  end
end
