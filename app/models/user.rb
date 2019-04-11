class User < ActiveRecord::Base
  has_many :exercises
  has_secure_password
  
  validates :username, presence: true
  validates :name, presence: true
  validates :password, presence: true
  validates :username, uniqueness: true
end
