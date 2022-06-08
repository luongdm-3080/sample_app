class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.regex.email

  validates :name, presence: true,
            length: {maximum: Settings.digits.length_name_max_50}
  validates :email, presence: true,
            length: {maximum: Settings.digits.length_email_max_255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true
  validates :password, presence: true,
            length: {minimum: Settings.digits.length_password_min_6}

  before_save :downcase_email

  private

  has_secure_password

  def downcase_email
    email.downcase!
  end
end
