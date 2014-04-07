class ChangeBracketPlacements < ActiveRecord::Migration
  def change
  	change_table :bracket_placements do |t|
  		t.string :game_type
  	end
  end
end
