class QuestionFollow
  attr_accessor :question_id, :follower_id

  def self.all
    data = QuestionDBConnection.instance.execute(<<-SQL)
      SELECT * FROM question_follows
    SQL

    data.map { |datum| QuestionFollow.new(datum) }
  end

  def self.find_by_id(id)
    options = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_follows
      WHERE id = ?
    SQL

    options.map { |option_hash| QuestionFollow.new(option_hash) }
  end

  def self.followers_for_question_id(question_id)
    options = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT users.*
      FROM question_follows
      JOIN users ON users.id = question_follows.follower_id
      JOIN questions ON questions.id = question_follows.question_id
      WHERE questions.id = ?
    SQL

    options.map { |options_hash| User.new(options_hash) }
  end

  def self.followed_questions_for_user_id(user_id)
    options = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT questions.*
      FROM question_follows
      JOIN users ON users.id = question_follows.follower_id
      JOIN questions ON questions.id = question_follows.question_id
      WHERE users.id = ?
    SQL

    options.map { |options_hash| Question.new(options_hash) }
  end

  def self.most_followed_questions(n)
    options = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT questions.*, COUNT(question_follows.follower_id) AS followers_per_question
      FROM question_follows
      JOIN questions ON questions.id = question_follows.question_id
      GROUP BY question_follows.question_id
      LIMIT ?
    SQL

    options.map { |options_hash| Question.new(options_hash) }
  end

  def initialize(options)
    @question_id = options['question_id']
    @follower_id = options['follower_id']
    @id = options['id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @question_id, @follower_id)
      INSERT INTO
        question_follows(question_id, follower_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @question_id, @follower_id, @id)
      UPDATE
        question_follows
      SET
        question_id = ?, follower_id = ?
      WHERE
        id = ?
    SQL
  end
end
