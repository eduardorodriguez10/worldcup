class ChangeUsersAttempsTime < ActiveRecord::Migration
  def change
  	change_column :users, :recovery_time, :datetime
  end
end
