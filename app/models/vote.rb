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

class Vote < ActiveRecord::Base
	attr_accessible :title, :description, :multi, :expiration, :options, :minoptions, :maxoptions, :caster_count
	validates :title, presence: true, length: { maximum: 15 }
	validates :description, length: { minimum: 6 }
	validates_presence_of :minoptions, :maxoptions

	has_many :user_voteships, dependent: :destroy
	has_many :cast_users, through: :user_voteships, source: :user, dependent: :destroy
	belongs_to :user
	has_many :options, dependent: :destroy

	attr_accessible :options_attributes
	accepts_nested_attributes_for :options, :reject_if => lambda { |a| a[:description].blank? }, allow_destroy: true
  # default_scope order: 'votes.created_at DESC'
  validate :must_be_not_expired
  validate :options_number

  def options_number
    errors.add(:base, "options_number limit errors") if minoptions <=0 || minoptions > maxoptions
  end
  def must_be_not_expired
    errors.add(:base, "Must be not expired") if expiration <= Time.now
  end
	def owner?(user)
		self.user_id == user.id
	end
end
