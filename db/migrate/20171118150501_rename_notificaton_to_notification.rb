class RenameNotificatonToNotification < ActiveRecord::Migration[5.1]
  def change
    rename_table :notificatons, :notifications
  end
end
