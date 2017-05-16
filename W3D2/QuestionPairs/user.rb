require 'sqlite3'
require 'singleton'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follows'
require_relative 'question_likes'

class QuestionDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :fname, :lname

  def self.all
    data = QuestionDBConnection.instance.execute(<<-SQL)
      SELECT *
      FROM users
    SQL

    data.map { |options| User.new(options) }
  end

  def self.find_by_id(id)
    options = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM users
      WHERE id = ?
    SQL

    options.map { |option_hash| User.new(option_hash) }
  end

  def self.find_by_name(fname, lname)
    data = QuestionDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users
      WHERE fname = ? AND lname = ?
    SQL

    options.map { |option_hash| User.new(option_hash) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users(fname, lname)
      VALUES
        (?,?)
      SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
      SQL
  end

  def authored_questions
    Question.find_by_author_id(@id) if @id
  end

  def authored_replies
    Reply.find_by_user_id(@id) if @id
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id) if @id
  end
end
