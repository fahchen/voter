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

require 'test_helper'

class UserVoteshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
