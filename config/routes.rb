Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "page_layout#home"

    get "page_layout/home"
    get "page_layout/about"
    delete "/logout", to: "sessions#destroy"
    get "show_user/:id", to: "users#show", as: "show_user"
    resources :budgets, only: %i(index new create) do
      collection do
        get "/:parent_id/new", to: "budgets#new", as: "new_with_parent"
        post "/:parent_id", to: "budgets#create", as: "with_parent"
      end
    end
    resources :spending_plans
    resources :share_plans, only: :create
    resources :statistics, only: :index
    resources :recycle_plans, only: %i(index update)
    devise_for :users
  end
end
