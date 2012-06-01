# == Schema Information
#
# Table name: votes
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :string(255)
#  multi       :boolean(1)
#  expiration  :datetime
#  minoptions  :integer(4)
#  maxoptions  :integer(4)
#  user_id     :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
