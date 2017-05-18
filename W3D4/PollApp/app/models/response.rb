# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Response < ActiveRecord::Base
  validates_presence_of :user_id, :answer_id
  validate :not_duplicate_response, :not_poll_author

  belongs_to :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_id

  has_one :question,
    through: :answer_choice,
    source: :question

  private

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.where(respondent: user_id).exists?
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:base] << 'Cannot answer twice'
    end
  end

  def poll_author?
    question.poll.author_id == user_id
  end

  def not_poll_author
    if poll_author?
      errors[:base] << "Cannot answer own poll"
    end
  end
end
