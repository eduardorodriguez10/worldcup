class AddAttempstoUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.integer :recovery_attemps
  	end
  end
end
