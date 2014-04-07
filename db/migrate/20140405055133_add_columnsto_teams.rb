class AddColumnstoTeams < ActiveRecord::Migration
  def change
  	change_table :teams do |t|
  		t.string :nombre
  		t.string :flag_url
  	end
  end
end
