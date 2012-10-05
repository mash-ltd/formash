ForMash::Engine.routes.draw do
  resources :templates do
    resources :fills, only: [:create]
  end
  root to: "templates#index"
end
