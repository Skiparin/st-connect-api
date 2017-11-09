class ChangeDataTypeOnTimeColumns < ActiveRecord::Migration[5.1]
  def change
  	change_column :experiences, :start_time, :date
  	change_column :experiences, :end_time, :date
  	change_column :educations, :start_time, :date
  	change_column :educations, :end_time, :date
  end
end
