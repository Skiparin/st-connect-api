class ChangeDefaultToHash < ActiveRecord::Migration[5.1]
  def change
    change_column_default :search_statistics, :number_of_searches, {}
  end
end
