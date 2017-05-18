# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates_presence_of :text, :poll_id

  belongs_to :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id

  has_many :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    # N+1 queries
    # answer_choices.map {|answer| [answer.text, answer.responses.count] }.to_h
    # Unnecessary response retrieval, just want database to COUNT
    # answer_choices.includes(:responses).map {|answer| [answer.text, answer.responses.length] }.to_h

    <<-SQL
    SELECT answer_choices.text, COUNT(responses.id)
    FROM answer_choices
    LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_id
    WHERE answer_choices.question_id = 1
    GROUP BY answer_choices.id
    SQL

    answer_choices.select("answer_choices.text, COUNT(responses.id) AS num_responses")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_id")
      .group("answer_choices.id")
      .map {|answer| [answer.text, answer.num_responses]}
      .to_h
  end
end
