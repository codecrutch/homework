require 'faker'

10.times {User.create!(user_name: Faker::Name.name)}

3.times {|i| Poll.create!(author_id: (i + 1), title: Faker::Lorem.words(2).join(' '))}

3.times do |poll_i|
  3.times do |ques_i|
    Question.create!(poll_id: (poll_i + 1), text: "#{ques_i + 1}. " + Faker::Lorem.words(3).join(' ') + '?')
    3.times {|ans_i| AnswerChoice.create!(question_id: ques_i + (3 * poll_i) + 1, text: "#{ans_i + 1}. " + Faker::Lorem.words(1).first)}
  end
end

27.times {|i| Response.create!(user_id: (i % 10) + 4, answer_id: (i + 1))}
