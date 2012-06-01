# == Schema Information
#
# Table name: user_voteships
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  vote_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class UserVoteship < ActiveRecord::Base
	belongs_to :user
	belongs_to :vote
end
