class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  validates :name, :presence => true,
            :length => {:maximum => 50, :minimum=>3}

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true,
            format: {with: email_regex}, uniqueness: {case_sensitive: false}

  validates :password, length: {minimum: 6}
end
