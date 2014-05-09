class AddSlugsToGroups < ActiveRecord::Migration
  def change
  	change_table :groups do |t|
  		t.string :slug
  	end
  end
end
