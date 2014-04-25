class Group < ActiveRecord::Base;
	has_many :memberships
	has_many :users, through: :memberships

	validates :group_name, presence: true
	validates :passcode, presence: true, on: :create, length: {minimum: 6}
	validates :organizer, presence: true
end