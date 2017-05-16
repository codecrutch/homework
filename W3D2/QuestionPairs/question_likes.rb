class QuestionLike
  # attr_accessor :question_id, :user_id, :thumbs_up
  #
  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_likes")
    data.map { |options| QuestionLike.new(options) }
  end

  def self.find_by_id(id)
    options = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL

    options.map { |option_hash| QuestionLike.new(option_hash) }
  end

  def self.likers_for_question_id(question_id)
    options = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT users.*
      FROM question_likes
      JOIN users ON users.id = question_likes.user_id
      JOIN questions ON questions.id = question_likes.question_id
      WHERE questions.id = ?
    SQL

    options.map { |options_hash| User.new(options_hash) }
  end

  def self.num_likes_for_question_id(question_id)
    num = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT COUNT(users.id) AS num_likes
      FROM question_likes
      JOIN users ON users.id = question_likes.user_id
      JOIN questions ON questions.id = question_likes.question_id
      WHERE questions.id = ?
      GROUP BY users.id
    SQL
    
    num[0] ||= {'num_likes'=>0}
    num.first['num_likes']
  end

  def initialize(options)
    @question_id = options['question_id']
    @user_id = options['user_id']
    @id = options['id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @question_id, @user_id)
      INSERT INTO
        question_likes(question_id, user_id)
      VALUES
        (?, ?)
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @question_id, @user_id, @id)
      UPDATE
        question_likes
      SET
        question_id = ?, user_id = ?
      WHERE
        id = ?
    SQL
  end
end
