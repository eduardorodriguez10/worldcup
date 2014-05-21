class AddDefinedToTeams < ActiveRecord::Migration
  def change
  	change_table :teams do |t|
  		t.boolean :r16_defined
  		t.boolean :quaterfinals_defined
  		t.boolean :semifinals_defined
  		t.boolean :final_defined
  		t.boolean :third_match_defined
  		t.boolean :third_place_defined
  		t.boolean :champion_defined
  	end
  end
end
