class Bracket < ActiveRecord::Base;
	belongs_to :user

	validates :user_id, presence: true
	validates :user_id, uniqueness: true, on: :create 
	validates :a1, :b2, :c1, :d2, :b1, :a2, :d1, :c2, :e1, :f2, :g1, :h2, :f1, :e2, :h1, :g2, :w49, :w50, :w51, :w52, :w53, :w54, :w55, :w56, :w57, :w58, :w59, :w60, :l61, :l62, :w61, :w62, :third, :champion, :presence => true

	before_save :generate_slug
    before_create :zero_scores
    after_save :update_memberships

    def zero_scores
        self.a1s = -1
        self.a2s = -1
        self.b1s = -1
        self.b2s = -1
        self.c1s = -1
        self.c2s = -1
        self.d1s = -1
        self.d2s = -1
        self.e1s = -1
        self.e2s = -1
        self.f1s = -1
        self.f2s = -1
        self.g1s = -1
        self.g2s = -1
        self.h1s = -1
        self.h2s = -1
        self.w49s = -1
        self.w50s = -1
        self.w51s = -1
        self.w52s = -1
        self.w53s = -1
        self.w54s = -1
        self.w55s = -1
        self.w56s = -1
        self.w57s = -1
        self.w58s = -1
        self.w59s = -1
        self.w60s = -1
        self.w61s = -1
        self.w62s = -1
        self.l61s = -1
        self.l62s = -1
        self.thirds = -1
        self.champions = -1
        self.score = 0
    end

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

    def update_memberships
        this_memberships = Membership.where(user_id: self.user_id)
        if (this_memberships.any?)
            this_memberships.each do |m|
                m.bracket_updated_at = self.updated_at 
                m.save
            end
        end
    end

end