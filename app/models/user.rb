class User < ActiveRecord::Base
  before_save { self.email = email.downcase } #downcase email before saving to database
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }    #uniqueness defaults true if passed an arg
  has_secure_password  #encrypts and checks password for confirmations
  validates :password, length: { minimum: 6 }
end
