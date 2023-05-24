require 'sqlite3'
require_relative 'db_manipulation'

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
    @db_object = SQLite3::Database.open "my_base.db"
    @db_object.results_as_hash = true
    @manipulator = DBManipulation.instance(@db_object)
  end

  def get_by_id(id)
    @manipulator.get_by_id(id)
  end

  def get_k_n_student_short_list(list_number, quan_element)
    @manipulator.get_k_n_student_short_list(list_number, quan_element)
  end

  def append(object)
    @manipulator.append(object)
  end

  def replace_by_id(id, obj)
    @manipulator.replace_by_id(id, obj)
  end

  def delete_by_id(id)
    @manipulator.delete_by_id(id)
  end

  def get_student_count
    @manipulator.get_student_count
  end
end

