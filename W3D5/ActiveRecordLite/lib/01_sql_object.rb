require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @cols ||=
    (cols = DBConnection.execute2(<<-SQL)
    SELECT *
    FROM #{table_name}
    SQL

    @cols = cols.first.map(&:intern))
  end

  def self.finalize!
    columns.each do |column_name|
      define_method(column_name) do
        attributes[column_name]
      end

      define_method("#{column_name}=") do |val|
        attributes[column_name] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    options = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{table_name}
    SQL
    parse_all(options)
  end

  def self.parse_all(results)
    results.map { |options_hash| new(options_hash)}
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id: id)
      SELECT *
      FROM #{table_name}
      WHERE #{table_name}.id = :id
    SQL

    result.nil? ? nil : parse_all(result).first
  end

  def initialize(params = {})
    cols = self.class.columns

    params.each do |method,val|
      if cols.include?(method.intern)
        send("#{method}=".intern, val) if val
      else
        raise "unknown attribute '#{method}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    attributes.values
  end

  def insert
    cols = self.class.columns[1..-1]
    params = cols.join(",")
    interps = ("?," * cols.length).chop

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name}(#{params})
      VALUES
        (#{interps})
    SQL

    send(:id=,DBConnection.last_insert_row_id)
  end

  def update
    cols = self.class.columns[1..-1]
    params = cols.join(" = ?,")
    att_vals = attribute_values[1..-1]

    DBConnection.execute(<<-SQL, *att_vals)
      UPDATE
        #{self.class.table_name}
      SET
        #{params} = ?
      WHERE
        id = #{attributes[:id]}
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
