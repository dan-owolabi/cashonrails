class IdentityVerification < ApplicationRecord
  belongs_to :merchant
  belongs_to :admin_user

  validates :id_type, inclusion: { in: %w[bvn nin] }
  validates :id_number, presence: true, format: { with: /\A\d{11}\z/, message: "must be exactly 11 digits" }

  scope :for_id, ->(id_number) { where(id_number: id_number) }
  scope :recent, -> { order(created_at: :desc) }

  def bvn? = id_type == "bvn"
  def nin? = id_type == "nin"
  def verified? = status == "verified"
  def failed? = status == "failed"

  def id_type_label
    id_type.upcase
  end
end
