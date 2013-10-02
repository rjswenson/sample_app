class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy  #if a user is destroyed, microposts from them will be destroyed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed  #source OVERRIDES default of user.followeds since its unnatural
  #has_many through looks for a foreign key tied to singular of association (followeds/followed_users)
  before_save { self.email = email.downcase } #downcase email before saving to database
  before_create :create_remember_token   #creates remember token for new user

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }    #uniqueness defaults true if passed an arg
  has_secure_password  #encrypts and checks password for confirmations
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    #this is a preliminary.  See 'Following Users' for full.
    Micropost.where("user_id = ?", id)
  end
  
  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
