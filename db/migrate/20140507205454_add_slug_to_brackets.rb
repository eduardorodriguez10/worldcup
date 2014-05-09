class AddSlugToBrackets < ActiveRecord::Migration
  def change
  	change_table :brackets do |t|
  		t.string :slug 
  	end
  end
end
