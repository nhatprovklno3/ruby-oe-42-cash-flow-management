Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "page_layout#home"

    get "page_layout/home"
    get "page_layout/about"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: [:new, :create]
  end
end
