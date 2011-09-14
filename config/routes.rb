Debate::Application.routes.draw do

  get "home/index"

  get 'login', :to => 'twitter#login', :as => "login"
  get 'logout', :to => 'twitter#logout', :as => "logout"

  get "twitter/after_login"

  resources :debate_questions, :only => [:index, :show, :create], :shallow => true do
    resources :comments, :only => [:create] do
      resource :comment_votes, :only => [:create]
    end

    resources :debate_votes, :only => [:create]
  end

  root :to => "home#index"

end
