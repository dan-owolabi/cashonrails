class Admin::BaseController < ApplicationController
  before_action :authenticate_admin_user!

  layout "admin"

  private

  def require_compliance_access!
    unless current_admin_user.compliance_admin?
      redirect_to admin_root_path, alert: "You don't have permission to access this page."
    end
  end
end
