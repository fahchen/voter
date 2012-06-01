# == Schema Information
#
# Table name: users
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean(1)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class User < ActiveRecord::Base
	attr_accessible :name, :password, :password_confirmation
	validates :name, presence: true, length: { minimum: 4, maximum: 8 }, uniqueness: true
	validates :password, length: { minimum: 6 }
	has_secure_password
	before_save :create_remember_token

	has_many :user_voteships, dependent: :destroy
	has_many :cast_votes, through: :user_voteships, source: :vote, dependent: :destroy
	has_many :votes, dependent: :destroy

	attr_accessible :option_ids
	has_many :user_optionships, dependent: :destroy
	has_many :options, through: :user_optionships, dependent: :destroy

	private
	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

end
