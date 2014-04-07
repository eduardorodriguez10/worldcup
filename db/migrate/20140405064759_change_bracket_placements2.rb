class ChangeBracketPlacements2 < ActiveRecord::Migration
  def change
  	change_table :bracket_placements do |t|
  		t.string :game_number
  		t.string :selection_type
  		t.string :selection_code
  	end
  end
end
