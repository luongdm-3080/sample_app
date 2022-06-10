class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.regex.email

  attr_accessor :remember_token, :activation_token

  validates :name, presence: true,
            length: {maximum: Settings.digits.length_name_max_50}
  validates :email, presence: true,
            length: {maximum: Settings.digits.length_email_max_255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true
  validates :password, presence: true,
            length: {minimum: Settings.digits.length_password_min_6},
            allow_nil: true

  scope :sort_name, ->{order :name}
  scope :activated, ->{where activated: true}

  before_save :downcase_email
  before_create :create_activation_digest

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end

      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")

    return false unless digest

    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns(activated: true,
                   activated_at: Time.zone.now,
                   activation_digest: nil)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  has_secure_password

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
