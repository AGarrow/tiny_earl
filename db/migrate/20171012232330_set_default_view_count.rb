class SetDefaultViewCount < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :earls, :view_count, 0
  end
end
