require_relative 'data_list'
require_relative 'lwl_for_view'

class DataListLaboratoryWork < DataList

  def initialize(lw_obj_arr)
    super
  end

  def arr=(lw_obj_arr)
    raise(ArgumentError, 'Массив может содержать только элементы LaboratoryWorkLight!') unless valid_array?(lw_obj_arr)
    @arr = lw_obj_arr
    self.data = LWLForView.new(@arr)
    self.notify if @subscribers
  end

  def notify
    @subscribers.each { |obj| obj.update(self.data) }
  end

  def get_selected
    @arr.find { |lw_light_obj| lw_light_obj.number == @select.first }.number
  end

  protected

  def valid_array?(array)
    return true if array.empty?
    array.all? { |obj| obj.is_a?(LaboratoryWorkLight) }
  end
end
