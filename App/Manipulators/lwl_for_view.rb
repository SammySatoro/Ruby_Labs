

class LWLForView
  def initialize(data_list_lw_light)
    @arr = extract_from_data_list(data_list_lw_light)
  end

  def get(i,j)
    @arr[i][j]
  end

  def n_rows
    @arr.size.nil? ? 0 : @arr.size
  end

  def n_columns
    @arr[0].nil? ? 0 : @arr[0].size
  end

  protected

  def extract_from_data_list(data_list)
    acc = []
    data_list.each do |lw_light_obj|
      getters = lw_light_obj.instance_variables
      getters.map! { |sym| sym.to_s.gsub(/@/,'') }
      getters.map! { |field| lw_light_obj.send(field) }
      acc << getters
    end
    acc
  end
end
