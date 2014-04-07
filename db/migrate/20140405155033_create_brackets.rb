class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
    	t.integer :user_id
    	t.integer :a1
    	t.integer :b2
    	t.integer :c1
    	t.integer :d2
    	t.integer :b1
    	t.integer :a2
    	t.integer :d1
    	t.integer :c2
    	t.integer :e1
    	t.integer :f2
    	t.integer :g1
    	t.integer :h2
    	t.integer :f1
    	t.integer :e2
    	t.integer :h1
    	t.integer :g2
    	t.integer :w49
    	t.integer :w50
    	t.integer :w51
    	t.integer :w52
    	t.integer :w53
    	t.integer :w54
    	t.integer :w55
    	t.integer :w56
    	t.integer :w57
    	t.integer :w58
    	t.integer :w59
    	t.integer :w60
    	t.integer :l61
    	t.integer :l62
    	t.integer :w61
    	t.integer :w62
    	t.integer :third
    	t.integer :chamption
    	t.timestamps 
    end
  end
end
