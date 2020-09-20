class User < ApplicationRecord
  attr_accessor :password

  # using a join table to get followed events
  has_many :event_follows
  has_many :followed_events, :through => :event_follows, :source => :event

  # events created by me
  has_many :events

  # using a join table to get followed and following users (self join)
  has_many :followed_users, :class_name => 'UserFollow', :foreign_key => 'follower_id'
  has_many :followees, :through => :followed_users
  has_many :following_users, :class_name => 'UserFollow', :foreign_key => 'followee_id'
  has_many :followers, through: :following_users

  before_save :encrypt_password

  validates :name, presence: true
  validates :email, { presence: true, uniqueness: true }
  validates :password, confirmation: true, if: :password_required?
  validates :about, length: { maximum: 500 }
  validates :city, length: { maximum: 255 }
  validates :profile, length: { maximum: 255 }

  # do the encryption if password is given
  def encrypt_password
    return if @password.blank?
    if self.new_record? then self.salt = SecureRandom.base64(16) end
    self.encrypted_password = User.encrypt(@password, self.salt)
  end

  # create a random password when forgetting password
  def random_password
    self.salt = SecureRandom.base64(16)
    pass = SecureRandom.alphanumeric(16)
    self.encrypted_password = User.encrypt(pass, self.salt)
    return pass
  end
  
  # static method for checking credentials
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user and user.authenticated?(password) ? user : nil
  end

  # method for matching input password with our encrypted_password
  def authenticated?(password)
    self.encrypted_password == User.encrypt(password, self.salt)
  end

  def password_required?
    self.new_record? or not @password.blank?
  end

  private
    # static method
    def self.encrypt(pass, salt)
      Digest::SHA1.hexdigest(pass + salt)
    end 
end
