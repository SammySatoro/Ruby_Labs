# frozen_string_literal: true

class StudentListTest
  def initialize(some_adapter)
    @adapter_obj = some_adapter
  end

  def get_by_id(id)
    @adapter_obj.get_by_id(id)
  end

  def get_k_n_student_short_list(list_number, quan_element, exist_data_list=nil, filters_hash=nil)
    @adapter_obj.get_k_n_student_short_list(list_number, quan_element, exist_data_list, filters_hash)
  end

  def append(object)
    @adapter_obj.append(object)
  end

  def replace_by_id(id, object)
    @adapter_obj.replace_by_id(id, object)
  end

  def delete_by_id(id)
    @adapter_obj.delete_by_id(id)
  end

  def get_student_count
    @adapter_obj.get_student_count
  end

  def id_count
    @adapter_obj.id_count
  end
end
