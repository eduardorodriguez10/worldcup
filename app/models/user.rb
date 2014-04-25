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
end