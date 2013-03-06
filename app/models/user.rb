class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :priv
  has_secure_password

  before_save {|user| user.email=user.email.downcase}
  before_save :create_remember_token

  validates :name, uniqueness: true, allow_blank: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with:VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6 }, presence: true
  #validates :password_confirmation, presence: true
  validates :priv, format: {with: /\A\b(admin|simple)\b\z/}

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
