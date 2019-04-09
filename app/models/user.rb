class User < ActiveRecord::Base
  has_many :exercises
  has_secure_password
  
end
