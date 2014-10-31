class User < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 3..20, :on => :create

  before_create :init_password

  def self.authenticate(username, password)
    user = User.find_by(:username => username)

    unless user.nil?
      password_hash = BCrypt::Engine.hash_secret(password, user.salt)
      return user if user.password_hash == password_hash
    end
    nil
  end

  def init_password
    self.salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(@password, salt)
  end

  def password=(password)
    @password = password
  end

  def password
    @password
  end
end
