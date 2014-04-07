class ChangeBrackets < ActiveRecord::Migration
  def change
  	rename_column :brackets, :chamption, :champion
  end
end
