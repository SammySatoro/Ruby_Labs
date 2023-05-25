require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/student_list.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/SourceManagement/Adapters/db_adapter.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_student_short.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/SourceManagement/Adapters/file_content_adapter.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/View/student_list_view.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Controllers/data_list_contract.rb'
require 'logger'
require 'sqlite3'

class StudentListController

  attr_reader :student_list_obj, :data_list_obj

  def initialize(view_obj, logger_mode=:all)
    @view_obj = view_obj
    @data_list_obj = DataListStudentShort.new([])
    @data_list_obj.subscribe(@view_obj)
    set_logger(logger_mode)
  end

  def on_student_list_view_created(adapter_type)
    begin
    adapter = adapter_type.is_a?(Hash) ? FileContentAdapter.new(adapter_type.delete(:json_file)) : DBAdapter.new
    @student_list_obj = StudentList.new(adapter)
    @logger.add(Logger::INFO, "StudentListView was created")
    rescue SQLException => error
      @logger.add(Logger::ERROR, "SQLITE3\n#{error}")
    rescue => some_error
      @logger.add(Logger::ERROR, "#{some_error}")
    end
  end

  def refresh_data(page=@view_obj.current_page, quan_rows=@view_obj.quan_rows, filters=nil)
    @data_list_obj = @student_list_obj.get_k_n_student_short_list(page, quan_rows, filters, @data_list_obj)
    @view_obj.update_total_count(@student_list_obj.get_student_count)
    @data_list_obj.notify
    @logger.add(Logger::INFO, "The table has been updated")
  end


  def set_logger(symbol)
    @logger = case symbol
    when :all
      Logger.new($stdout, Logger::DEBUG, progname: 'StudenListController')
    when :error
      Logger.new($stdout, Logger::ERROR, progname: 'StudenListController')
    when :hybrid
      Logger.new($stdout, Logger::INFO, progname: 'StudenListController')
    else
      Logger.new($stdout, Logger::DEBUG, progname: 'StudenListController')
    end
  end
end

