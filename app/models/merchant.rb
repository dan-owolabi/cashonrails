class Merchant < ApplicationRecord
  has_many :identity_verifications, dependent: :destroy

  validates :business_name, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected suspended] }

  scope :approved, -> { where(status: "approved") }

  def status_color
    case status
    when "approved" then "success"
    when "rejected" then "danger"
    when "suspended" then "warning"
    else "neutral"
    end
  end
end
