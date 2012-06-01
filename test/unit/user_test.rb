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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
