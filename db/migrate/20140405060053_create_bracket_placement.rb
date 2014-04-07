class CreateBracketPlacement < ActiveRecord::Migration
  def change
    create_table :bracket_placements do |t|
    	t.string :placement 
    	t.date :game_date
    	t.integer :team_id
    end
  end
end
