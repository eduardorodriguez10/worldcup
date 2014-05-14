class AddSelectionsToTeams < ActiveRecord::Migration
  def change
  	change_table :teams do |t|
  		t.integer :r16_selections
  		t.integer :quaterfinals_selections
  		t.integer :semifinals_selections
  		t.integer :final_selections
  		t.integer :third_match_selections
  		t.integer :champion_selections
  		t.integer :third_selections
  	end
  end
end
