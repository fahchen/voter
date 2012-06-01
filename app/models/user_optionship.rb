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

class UserOptionship < ActiveRecord::Base
	belongs_to :user
	belongs_to :option
end
