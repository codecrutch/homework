# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  COLORS = %w[black white orange grey brown]
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS,
              message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F), message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests,
      class_name: :CatRentalRequest,
      primary_key: :id,
      foreign_key: :cat_id,
      dependent: :destroy

  def age
    Date.today.year - birth_date.year
  end




end
