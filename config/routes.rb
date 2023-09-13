Rails.application.routes.draw do
  require 'resque/server'
  mount Resque::Server, at: '/admin/jobs'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :links, only: %i[index create show]
    end
  end
end
