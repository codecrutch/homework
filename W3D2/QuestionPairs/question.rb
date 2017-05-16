class Question
  attr_accessor :title, :body
  attr_reader :author_id

  def self.all
    data = QuestionDBConnection.instance.execute(<<-SQL)
      SELECT * FROM questions
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    options = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL

    options.map { |option_hash| Question.new(option_hash) }
  end

  def self.find_by_author_id(author_id)
    options = QuestionDBConnection.instance.execute(<<-SQL, author_id)
      SELECT *
      FROM questions
      WHERE author_id = ?
    SQL

    options.map { |option_hash| Question.new(option_hash) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def initialize(options)
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
    @id = options['id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions(title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @author_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    User.find_by_id(@author_id) if @author_id
  end

  def replies
    Reply.find_by_question_id(@id) if @id
  end

  def followers
    QuestionFollow.followers_for_question_id(@id) if @id
  end
end
