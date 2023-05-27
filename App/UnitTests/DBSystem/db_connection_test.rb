require 'sqlite3'

class DBConnectionTest

  private_class_method :new

  @instance_mutex = Mutex.new

  def self.instance
    return @instance if @instance
    @instance_mutex.synchronize do
      @instance ||= new
    end
    @instance
  end

  def initialize
    @db_object = SQLite3::Database.open 'D:\RubyProject\DoneApp\UnitTests\DBSystem\local_db_for_test.db'
    @db_object.results_as_hash = true
  end

  def get_cursor
    @db_object
  end
end

#DBConnectionTest.instance
