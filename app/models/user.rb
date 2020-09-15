class User < ApplicationRecord
  attr_accessor :password
  has_many :events
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
