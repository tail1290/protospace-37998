class RenameProfleColumnToProfile < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :profle, :profile
  end
end
