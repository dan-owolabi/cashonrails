class Admin::Merchants::VerifyIdentitiesController < Admin::BaseController
  before_action :require_compliance_access!
  before_action :set_merchant

  def show
  end

  def verify
    @verification = @merchant.identity_verifications.build(
      id_type: params[:id_type],
      id_number: params[:id_number],
      admin_user: current_admin_user
    )

    unless @verification.valid?
      render turbo_stream: turbo_stream.replace(
        "verify-identity-form",
        partial: "admin/merchants/verify_identities/form",
        locals: { merchant: @merchant, verification: @verification, errors: @verification.errors.full_messages }
      )
      return
    end

    result = SamsonIdentityService.new(id_type: params[:id_type], id_number: params[:id_number]).call

    if result.success
      data = result.data
      @verification.assign_attributes(
        full_name: data[:full_name],
        date_of_birth: data[:date_of_birth],
        phone_number: data[:phone_number],
        gender: data[:gender],
        image_url: data[:image_url],
        raw_response: data[:raw_response],
        status: "verified"
      )
      @verification.save!

      render turbo_stream: turbo_stream.replace(
        "identity-result-modal",
        partial: "admin/merchants/verify_identities/result_modal",
        locals: { verification: @verification }
      )
    else
      render turbo_stream: turbo_stream.replace(
        "verify-identity-form",
        partial: "admin/merchants/verify_identities/form",
        locals: { merchant: @merchant, verification: @verification, errors: [result.error] }
      )
    end
  end

  def logs
    @id_number = params[:q].to_s.strip
    @verifications = if @id_number.present?
      @merchant.identity_verifications.for_id(@id_number).recent
    else
      IdentityVerification.none
    end

    render turbo_stream: turbo_stream.replace(
      "verification-logs",
      partial: "admin/merchants/verify_identities/logs",
      locals: { verifications: @verifications, id_number: @id_number }
    )
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
