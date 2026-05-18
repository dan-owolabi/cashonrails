class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.order(created_at: :desc)
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end
