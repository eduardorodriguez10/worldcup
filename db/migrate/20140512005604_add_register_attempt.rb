class AddRegisterAttempt < ActiveRecord::Migration
  def change
  	create_table :register_attempts do |t|
    	t.string :email
    	t.string :passcode
    	t.timestamps
    end
  end
end
