class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :identity_verifications

  def compliance_admin?
    compliance_access?
  end
end
