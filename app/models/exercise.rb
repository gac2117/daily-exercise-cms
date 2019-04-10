class Exercise < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :minutes, presence: true
  validates :date, presence: true
end
