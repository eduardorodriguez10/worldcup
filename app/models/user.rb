class User < ActiveRecord::Base;
	has_one :bracket
	has_many :memberships
	has_many :groups, through: :memberships
	
	has_secure_password validations: false
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 6}
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :country, presence: true

	before_save :generate_slug

	def generate_slug
		self.slug = self.first_name.gsub(/['`]/,"").downcase
    	self.slug = self.slug.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').to_s
    	self.slug = self.slug.gsub(/\s*@\s*/, "at")
    	self.slug = self.slug.gsub(/\s*&\s*/, "and")
    	self.slug = self.slug.gsub(/\s*[^A-Za-z0-9\.\-]\s*/, '_')
    	self.slug = self.slug.gsub(/_+/,"_")
    	self.slug = self.slug.gsub(/\A[_\.]+|[_\.]+\z/,"")
    	testslug = self.slug
    	slug_match = User.where(slug: testslug).where.not(id: self.id).first
    	i = 2;
    		while (slug_match != nil) do
      		testslug = self.slug + i.to_s
      		slug_match = User.where(slug: testslug).where.not(id: self.id).first
      		i +=1
    		end
    	self.slug = testslug
	end 

	def to_param
		self.slug
	end

	def is_admin?
		self.admin
	end
end