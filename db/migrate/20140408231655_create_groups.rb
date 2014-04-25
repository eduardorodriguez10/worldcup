class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.string 	:group_name
    	t.integer	:leader
    	t.integer	:organizer
    	t.string	:passcode
    	t.timestamps
    end
  end
end
