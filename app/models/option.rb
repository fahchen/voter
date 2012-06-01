# == Schema Information
#
# Table name: options
#
#  id          :integer(4)      not null, primary key
#  description :string(255)
#  vote_id     :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Option < ActiveRecord::Base
	attr_accessible :description
	validates :description, presence: true, length: { maximum: 60 }

	has_many :user_optionships, dependent: :destroy
	belongs_to :vote
	belongs_to :user
end
