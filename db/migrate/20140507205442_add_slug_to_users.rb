class AddSlugToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :slug
  	end
  end
end
