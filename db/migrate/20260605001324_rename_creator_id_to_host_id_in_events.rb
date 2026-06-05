class RenameCreatorIdToHostIdInEvents < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :creator_id, :host_id
  end
end
