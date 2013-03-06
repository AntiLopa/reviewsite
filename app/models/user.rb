class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :priv
  has_secure_password

  before_save {|user| user.email=user.email.downcase}

  validates :name, uniqueness: true, allow_blank: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with:VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6 }
  validates :password_confirmation, presence: true
  validates :priv, format: {with: /\A\b(admin|simple)\b\z/}
end
