require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/SourceManagement/FileSystem/file_content.rb'

class FileContentAdapter

  def initialize(path)
    @file_content_obj = FileContent.new(path)
  end

  def get_by_id(id)
    @file_content_obj.get_by_id(id)
  end

  def get_k_n_student_short_list(list_number, quan_element, filters_hash=nil, exist_data_list=nil)
    @file_content_obj.get_k_n_student_short_list(list_number, quan_element, filters_hash, exist_data_list)
  end

  def append(object)
    @file_content_obj.append(object)
  end

  def replace_by_id(id, object)
    @file_content_obj.replace_by_id(id, object)
  end

  def delete_by_id(id)
    @file_content_obj.delete_by_id(id)
  end

  def get_student_count
    @file_content_obj.get_student_count
  end

  def id_count
    @file_content_obj.id_count
  end

end
