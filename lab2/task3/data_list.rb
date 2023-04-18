
class DataList

  protected

  attr_writer :data

  public

  attr_reader :names, :data

  def initialize(data_array)
    self.list = data_array
    @selected = []
  end

  def list=(data_array)
    @list = []
    data_array.each_with_index do |data, index|
      @list << [index, data]
    end
    nil
  end

  def add_to_selection(number)
    @selected << number
    @selected.flatten!
    @selected.uniq!
    nil
  end

  def get_selected
    selection = []
    @selected.each do |number|
      result = (@list.find { |pair| pair[0] == number })

      selection << result[1].id
    end
    selection
  end

  def clear_selected
    @selected = []
    nil
  end

  def get_names
    get_names_hop
  end

  def get_data
    get_data_hop
  end

  protected

  def get_names_hop; end

  def get_data_hop; end

end