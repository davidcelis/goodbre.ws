class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation
  has_secure_password
  recommends :beers

  before_create { generate_token(:auth_token) }

  # validates_length_of :password, :minimum => 6, :on => :create

  # validates_exclusion_of :username, :in => %w( admin superuser root goodbrews guest ), :message => 'is reserved'
  # validates_format_of :username, :with => /^\w+$/
  # validates_uniqueness_of :username, :case_sensitive => false, :message => 'has already been taken'
  # validates_length_of :username, :within => 4..20
  # validates_presence_of :username

  # validates_format_of :email, :with => /@/
  # validates_uniqueness_of :email, :case_sensitive => false, :message => 'is already in use'
  # validates_presence_of :email

  def to_param
    username.parameterize
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token :password_reset_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def self.from_param(param)
    where(:username => param).first
  end

  def self.find_by_login(login)
    where('username = ? OR email = ?', login, login).first
  end
end
