require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_query = ""
    att_vals = []
    params.each_with_index do |(column, value), idx|
      att_vals << value
      where_query += "#{column} = ?"
      unless idx == params.length - 1
        where_query += " AND "
      end
    end

    data = DBConnection.execute(<<-SQL, *att_vals)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_query}
    SQL

    parse_all(data)
  end
end

class SQLObject
  extend Searchable
  # Mixin Searchable here...
end
