

class LaboratoryWorkFolder

  def initialize(some_adapter)
    @adapter_obj = some_adapter
  end

  def get_by_number(number)
    @adapter_obj.get_by_number(number)
  end

  def append(object)
    @adapter_obj.append(object)
  end

  def replace_by_number(number, object)
    @adapter_obj.replace_by_number(number, object)
  end

  def delete_by_number(number)
    @adapter_obj.delete_by_number(number)
  end

  def get_all_lw(exist_data_list=nil)
    @adapter_obj.get_all_lw(exist_data_list)
  end

  def last_date_of_issue
    @adapter_obj.last_date_of_issue
  end

  def get_lw_count
    @adapter_obj.get_lw_count
  end

  def count_number
    @adapter_obj.count_number
  end
end
