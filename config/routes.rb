Debate::Application.routes.draw do

  get "home/index"

  get 'login', :to => 'twitter#login', :as => "login"
  get 'logout', :to => 'twitter#logout', :as => "logout"

  get "twitter/after_login"

  resources :debate_questions, :shallow => true do
    resources :comments do
      resource :comment_votes
    end

    resources :debate_votes
  end

  root :to => "home#index"

end
