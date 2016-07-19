class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :post
  has_many :ratings, dependent: :destroy
  has_many :rated_posts, through: :ratings,source: :post
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_secure_password
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def set_token
    self.reset_token = User.new_token
    update_attribute(:reset_token, self.reset_token)
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 3.hours.ago
  end

  def increment_login_lockout_count
    if self.login_lockout_count <= 10
      self.login_lockout_count += 1
      update_attribute(:login_lockout_count, self.login_lockout_count)
    else
      update_attribute(:account_lockout, true)
      update_attribute(:login_lockout_count, 0)
    end
  end

  def unlock_account
    update_attribute(:account_lockout, false)
  end
end
