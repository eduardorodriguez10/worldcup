class ChangePositionsinTeams < ActiveRecord::Migration
  	def change
  	change_column :teams, :r16_position, :string
  	change_column :teams, :quaterfinals_position, :string
  	change_column :teams, :semifinals_position, :string
  end
end
