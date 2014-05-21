class AddRealtoTeams < ActiveRecord::Migration
  def change
  	change_table :teams do |t|
  		t.text :r16_position
  		t.boolean :r16_madeit
  		t.text :quaterfinals_position
  		t.boolean :quaterfinals_madeit
  		t.text :semifinals_position
  		t.boolean :semifinals_madeit
  		t.boolean :final_madeit
  		t.boolean :third_match_madeit
  		t.boolean :third_place_madeit
  		t.boolean :champion_madeit
  	end
  end
end
