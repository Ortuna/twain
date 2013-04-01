##
# A MySQL connection:
# DataMapper.setup(:default, 'mysql://user:password@localhost/the_database_name')
#
# # A Postgres connection:
# DataMapper.setup(:default, 'postgres://user:password@localhost/the_database_name')
#
# # A Sqlite3 connection
# DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "development.db"))
#

DataMapper.logger = logger
DataMapper::Property::String.length(255)

case Padrino.env
when :test
  test_db_path = Padrino.root('tmp', "test.db")
  FileUtils.rm(test_db_path) if File.exists?(test_db_path)
  DataMapper.setup(:default, "sqlite3://" + test_db_path)
when :development
  DataMapper.setup(:default, "sqlite3://" + Padrino.root('tmp', "development.db"))
end
