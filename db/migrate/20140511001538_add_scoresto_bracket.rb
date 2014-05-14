class AddScorestoBracket < ActiveRecord::Migration
  def change
  	change_table :brackets do |t|
  		t.integer :a1s
  		t.integer :b2s
  		t.integer :c1s
  		t.integer :d2s
  		t.integer :b1s
  		t.integer :a2s
  		t.integer :d1s
  		t.integer :c2s
  		t.integer :e1s
  		t.integer :f2s
  		t.integer :g1s
  		t.integer :h2s
  		t.integer :f1s
  		t.integer :e2s
  		t.integer :h1s
  		t.integer :g2s
  		t.integer :w49s
  		t.integer :w50s
  		t.integer :w51s
  		t.integer :w52s
  		t.integer :w53s
  		t.integer :w54s
  		t.integer :w55s
  		t.integer :w56s
  		t.integer :w57s
  		t.integer :w58s
  		t.integer :w59s
  		t.integer :w60s
  		t.integer :l61s
  		t.integer :l62s
  		t.integer :w61s
  		t.integer :w62s
  		t.integer :thirds
  		t.integer :champions
  		t.integer :score
  	end
  end
end
