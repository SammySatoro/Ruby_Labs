require 'sqlite3'
require 'singleton'

class DBManipulation

  private_class_method :new

  @instance_mutex = Mutex.new

  def self.instance(db_obj)
    return @instance if @instance
    @instance_mutex.synchronize do
      @instance ||= new(db_obj)
    end
    @instance
  end

  def initialize(db_obj)
    @database_object = db_obj
  end

  def get_by_id(id)
    @database_object.execute "select last_name, first_name, patronymic,
                              phone, telegram, email
                              from Students where id=#{id}"
  end

  def get_k_n_student_short_list(list_number, quan_element)
    @database_object.execute "select * from Students limit #{(list_number - 1) * quan_element}, #{quan_element}"
  end

  def append(object)
    temp = object.to_s.split(', ').map! { |el| el == '-' ? 'null' : el}
    values = ""
    temp.each { |el| values += "'#{el}',"}
    @database_object.execute "insert into Students (#{self.attr}) values (#{values[0..values.length - 2]})"
  end

  def replace_by_id(id, object)
    hash = object.as_hash
    hash.delete("id")
    hash.transform_values! { |value| value.nil? ? 'null' : value }
    request = ''
    hash.each_pair { |key, value| request += "#{key.to_s} = '#{value}',"}
    @database_object.execute "update Students set #{request[0..request.length-2]} where id = #{id}"
  end

  def delete_by_id(id)
    @database_object.execute "delete from Students where id=#{id}"
  end

  def get_student_count
    hash = @database_object.execute  "select count(*) from Students"
    hash.first.values.first
  end

  protected

  def attr
    "last_name, first_name, patronymic, git, phone, telegram, email"
  end

end

