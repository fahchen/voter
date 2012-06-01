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

require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
