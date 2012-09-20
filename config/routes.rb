ForMash::Engine.routes.draw do
  resources :templates
  root to: "templates#index"
end
