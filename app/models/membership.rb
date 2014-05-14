class Membership < ActiveRecord::Base;
	belongs_to :groups
	belongs_to :users
	before_create :zero_scores

	def zero_scores
		self.full_r16 = 0
		self.half_r16 = 0
		self.full_quaterfinals = 0
		self.half_quaterfinals = 0
		self.full_semifinals = 0
		self.half_semifinals = 0
		self.full_total = 0
		self.half_total = 0
		self.full_final = 0
		self.full_third = 0
		self.third = 0
		self.champion = 0
		self.score = 0
		self.last_viewed = Time.now()
		bracket = Bracket.find_by(user_id: self.user_id)
		if(bracket.nil?)
			self.bracket_updated_at = Datetime.now
		else
			if(bracket.updated_at == nil)
				self.bracket_updated_at = Datetime.now
			else 
				self.bracket_updated_at = bracket.updated_at 
			end
		end
	end
end