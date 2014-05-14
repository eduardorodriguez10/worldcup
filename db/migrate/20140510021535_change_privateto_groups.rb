class ChangePrivatetoGroups < ActiveRecord::Migration
  def change
  	rename_column :groups, :private, :isprivate
  end
end
