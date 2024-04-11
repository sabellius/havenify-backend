class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  PASSWORD_REQUIREMENTS = /\A
    (?=.*\d) # contain at least one digit
    (?=.*[a-z]) # contain at least one lowercase character
    (?=.*[A-Z]) # contain at least one uppercase character
    (?=.*[\W_]) # contain at least one special character
  /x

  PASSWORD_REQUIREMENTS_MESSAGE = 'must include at least one lowercase letter, one uppercase letter, one digit, and one special character'.freeze

  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { in: 8..128 },
                       format: { with: PASSWORD_REQUIREMENTS, message: PASSWORD_REQUIREMENTS_MESSAGE }, if: :password_required?

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
