class User < ActiveRecord::Base;
	has_one :bracket

	has_secure_password validations: false
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 6}
end