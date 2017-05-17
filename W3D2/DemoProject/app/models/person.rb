class Person < ActiveRecord::Base
  belongs_to :house
  validates_presence_of :name, :house_id
end
