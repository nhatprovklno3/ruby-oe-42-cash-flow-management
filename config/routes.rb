Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "page_layout#home"

    get "page_layout/home"
    get "page_layout/about"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
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
  end
end
