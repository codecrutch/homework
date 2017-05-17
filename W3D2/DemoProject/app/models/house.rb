class House < ActiveRecord::Base
  has_many :residents,
    class_name: :Person,
    foreign_key: :house_id,
    primary_key: :id

  validates_presence_of :address
end
