class AddScoresToMemberships < ActiveRecord::Migration
  def change
  	change_table :memberships do |t|
  		t.integer :full_r16
  		t.integer :half_r16
  		t.integer :full_quaterfinals
  		t.integer :half_quaterfinals
  		t.integer :full_semifinals
  		t.integer :half_semifinals
  		t.integer :full_total
  		t.integer :half_total
  		t.integer :score
  	end
  end
end
