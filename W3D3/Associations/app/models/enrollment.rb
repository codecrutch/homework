# == Schema Information
#
# Table name: enrollments
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Enrollment < ActiveRecord::Base
  belongs_to :student,
    class_name: :User,
    primary_key: :id,
    foreign_key: :student_id

  belongs_to :course,
    class_name: :Course,
    primary_key: :id,
    foreign_key: :course_id
end
