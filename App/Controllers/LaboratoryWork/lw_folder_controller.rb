require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/data_list_laboratory_work.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Manipulators/laboratory_work_folder.rb'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/SourceManagement/Adapters/db_adapter_for_lw.rb'

class LWFolderController

  attr_reader :lw_folder, :data_list

  def initialize(view)
    @view = view
    @data_list = DataListLaboratoryWork.new([])
    @data_list.subscribe(@view)
  end

  def on_lw_folder_view_created
    adapter = DBAdapterForLW.new
    @lw_folder = LaboratoryWorkFolder.new(adapter)
  end

  def refresh_data
    @data_list = @lw_folder.get_all_lw(@data_list)
    @data_list.notify
  end
end
