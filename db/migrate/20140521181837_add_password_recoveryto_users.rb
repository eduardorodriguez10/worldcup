class AddPasswordRecoverytoUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :password_recovery
  		t.datetime :recovery_time
  	end
  end
end
