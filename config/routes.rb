Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope ":locale", :locale => /\w{2}/ do
    scope "search" do
      resources :searches, path: '', only: [:show]
    end
    # TODO refactor
    resources :pages, path: '', only: [:show, :index] do
      resources :pages, path: '', only: [:show] do
        resources :pages, path: '', only: [:show] do
          resources :pages, path: '', only: [:show]
        end
      end
    end
  end

  match ':locale' => 'pages#show'

  root to: 'pages#show'

  resources :locales, only: :show
end