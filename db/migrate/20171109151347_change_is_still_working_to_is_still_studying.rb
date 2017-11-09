class ChangeIsStillWorkingToIsStillStudying < ActiveRecord::Migration[5.1]
  def change
  	rename_column :educations, :is_still_working, :is_still_studying
  end
end
