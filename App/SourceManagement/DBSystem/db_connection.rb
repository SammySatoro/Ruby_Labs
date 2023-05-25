require 'sqlite3'


class DBConnection
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
    @db_object = SQLite3::Database.open "/home/sammysatoro/RubyProjects/Ruby_Labs/App/SourceManagement/DBSystem/my_base.db"
    @db_object.results_as_hash = true
  end

  def get_cursor
    @db_object
  end

end

