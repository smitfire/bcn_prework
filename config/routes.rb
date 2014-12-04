# == Route Map
#
#    Prefix Verb   URI Pattern              Controller#Action
#      root GET    /                        users#index
#      user GET    /users/:id(.:format)     users#show
# exercises GET    /exercises(.:format)     exercises#index
#  exercise GET    /exercises/:id(.:format) exercises#show
#  sessions POST   /sessions(.:format)      sessions#create
#   session DELETE /sessions/:id(.:format)  sessions#destroy
#   answers GET    /answers(.:format)       answers#index
#           POST   /answers(.:format)       answers#create
#    answer GET    /answers/:id(.:format)   answers#show
#           PATCH  /answers/:id(.:format)   answers#update
#           PUT    /answers/:id(.:format)   answers#update
#           DELETE /answers/:id(.:format)   answers#destroy
#      page GET    /pages/*id               high_voltage/pages#show
#

Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: [:show]
  resources :exercises, only: [:index, :show]
  resources :sessions, only: [:create, :destroy]
  resources :answers, only: [:show, :index, :update]
  get '/answers/:id/spec' => 'answers#show_spec', as: :show_spec
end
