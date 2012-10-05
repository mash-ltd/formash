ForMash::Engine.routes.draw do
  resources :templates do
    resources :fills, only: [:index, :create]
  end

  resources :fills, only: :show

  root to: "templates#index"
end
