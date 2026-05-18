Rails.application.routes.draw do
  devise_for :admin_users

  namespace :admin do
    root "merchants#index"

    resources :merchants, only: [:index, :show] do
      scope module: :merchants do
        resource :verify_identity, only: [:show] do
          post :verify, on: :member
          get :logs, on: :member
        end
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "admin/merchants#index"
end
