class QuestionFollows
  # attr_accessor :title, :body
  # attr_reader :author_id
  #
  # def self.all
  #   data = QuestionDBConnection.instance.execute(<<-SQL)
  #     SELECT * FROM questions
  #   SQL
  # end
  #
  # def initialize(options)
  #   @title = options['title']
  #   @body = options['body']
  #   @author_id = options['author_id']
  # end
  #
  # def create
  #   raise "#{self} already in database" if @id
  #   QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @author_id)
  #     INSERT INTO
  #       questions(title, body, author_id)
  #     VALUES
  #       (?, ?, ?)
  #   SQL
  #   @id = QuestionDBConnection.instance.last_insert_row_id
  # end
  #
  # def update
  #   raise "#{self} not in database" unless @id
  #   QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @author_id, @id)
  #     UPDATE
  #       questions
  #     SET
  #       title = ?, body = ?, author_id = ?
  #     WHERE
  #       id = ?
  #   SQL
  # end

end
