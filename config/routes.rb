Rails.application.routes.draw do
  root to: 'github_repos#index'

  resources :github_repos, only: %i[index]
end
