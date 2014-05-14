class CreateFinalPositions < ActiveRecord::Migration
  def change
    create_table :final_positions do |t|
    	t.string  :position 
    	t.integer :team
    	t.timestamps
    end
  end
end
