class Bracket < ActiveRecord::Base;
	belongs_to :user

	validates :user_id, presence: true
	validates :user_id, uniqueness: true, on: :create 
	validates :a1, :b2, :c1, :d2, :b1, :a2, :d1, :c2, :e1, :f2, :g1, :h2, :f1, :e2, :h1, :g2, :w49, :w50, :w51, :w52, :w53, :w54, :w55, :w56, :w57, :w58, :w59, :w60, :l61, :l62, :w61, :w62, :third, :champion, :presence => true
end