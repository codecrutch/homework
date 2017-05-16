class Reply
  attr_accessor :body, :parent_id, :question_id, :user_id

  def self.all
    data = QuestionDBConnection.instance.execute(<<-SQL)
      SELECT * FROM replies
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    options = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL

    options.map { |option_hash| Reply.new(option_hash) }
  end

  def self.find_by_user_id(user_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM replies
      WHERE replies.user_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM replies
      WHERE replies.question_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @body = options['body']
    @parent_id = options['parent_id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @id = options['id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @body, @parent_id, @question_id, @user_id)
      INSERT INTO
        replies(body, parent_id, question_id, user_id)
      VALUES
        (?, ?, ?, ?)
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @body, @parent_id, @question_id, @user_id, @id)
      UPDATE
        replies
      SET
        body = ?, parent_id = ?, question_id = ?, user_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    User.find_by_id(@user_id) if @user_id
  end

  def question
    Question.find_by_id(@question_id) if @question_id
  end

  def parent_reply
    Reply.find_by_id(@parent_id) if @parent_id
  end

  def children_replies
    options = QuestionDBConnection.instance.execute(<<-SQL, @id) if @id
      SELECT *
      FROM replies
      WHERE replies.parent_id = ?
    SQL

    options.map { |options_hash| Reply.new(options_hash) }
  end

end
