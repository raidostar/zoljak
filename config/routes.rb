Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
  
  devise_scope :user do
    get 'login' => 'home#index', as: :new_user_session #로그인 화면
    post 'login' => 'members/sessions#create', as: :user_session #로그인(POST)
    delete '/users/sign_out' => 'members/sessions#destroy', as: :destroy_user_session #로그아웃
    get '/users/sign_up' => 'members/registers#new', as: :new_user_registration #회원가입
    post 'users' => 'members/registers#create', as: :user_registration #회원가입(POST)
    post 'users/email_check' => 'members/registers#email_check'
  end
  
  root 'home#index'

  get 'schools' => 'schools#index'
  get 'years' => 'years#index'
  get 'functions' => 'functions#index'
  get 'awards' => 'awards#index'
  get 'communities' => 'communities#index'
  get 'myworks' => 'myworks#index'  
end
