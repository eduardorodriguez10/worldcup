class Bracket < ActiveRecord::Base;
	belongs_to :user

	validates :user_id, presence: true
	validates :user_id, uniqueness: true, on: :create 
	validates :a1, :b2, :c1, :d2, :b1, :a2, :d1, :c2, :e1, :f2, :g1, :h2, :f1, :e2, :h1, :g2, :w49, :w50, :w51, :w52, :w53, :w54, :w55, :w56, :w57, :w58, :w59, :w60, :l61, :l62, :w61, :w62, :third, :champion, :presence => true

	before_save :generate_slug

	def generate_slug
		bracket_user = User.find(self.user_id)
    	self.slug = bracket_user.first_name.gsub(/['`]/,"").downcase
   	 	self.slug = self.slug.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').to_s
    	self.slug = self.slug.gsub(/\s*@\s*/, "at")
    	self.slug = self.slug.gsub(/\s*&\s*/, "and")
    	self.slug = self.slug.gsub(/\s*[^A-Za-z0-9\.\-]\s*/, '_')
    	self.slug = self.slug.gsub(/_+/,"_")
    	self.slug = self.slug.gsub(/\A[_\.]+|[_\.]+\z/,"")
    	testslug = self.slug
    	slug_match = Bracket.where(slug: testslug).where.not(id: self.id).first
    	i = 2;
    		while (slug_match != nil) do
      		testslug = self.slug + i.to_s
      		slug_match = Bracket.where(slug: testslug).where.not(id: self.id).first
      		i +=1
    		end
    	self.slug = testslug
    end

    def to_param
    	self.slug
    end

end