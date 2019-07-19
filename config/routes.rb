Rails.application.routes.draw do
  root 'fizz_buzzs#index'

  resources :jobs, only: [:index, :show] do
    member do
      get :poll
    end
  end

  resources :fizz_buzzs do
    member do
      get :increment
    end
    collection do
      get :generate
      get :increment_all
    end
  end

  resources :queues, only: [:index, :show]

end
