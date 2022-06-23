Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'authentication#login'
      post '/signup', to: 'authentication#signup'
      get '/posts/list_current_user_posts', to: 'posts#list_current_user_posts'
      get '/posts/list_posts_by_user_id', to: 'posts#list_posts_by_user_id'
      get '/*a', to: 'application#not_found'
      resources :posts do
        resources :comments, only: [:create, :update, :destroy]
      end
    end
  end
end
