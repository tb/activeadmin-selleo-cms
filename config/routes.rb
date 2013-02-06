Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope ":locale", :locale => /\w{2}/ do
    scope "search" do
      resources :searches, path: '', only: [:show]
    end
    # TODO refactor
    match ':slug5(/:slug4(/:slug3(/:slug2(/:slug1))))'  => 'pages#show'
    resources :pages, path: '', only: [:show, :index]
  end

  match ':locale' => 'pages#show'

  root to: 'pages#show'

  resources :locales, only: :show
end