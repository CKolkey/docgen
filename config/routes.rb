Rails.application.routes.draw do
  resources :scripts
  root "scripts#index"
end
