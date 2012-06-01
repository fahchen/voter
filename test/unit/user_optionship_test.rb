# == Schema Information
#
# Table name: user_optionships
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  option_id  :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class UserOptionshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
