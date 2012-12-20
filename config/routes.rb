ActiveadminSelleoCms::Engine.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", :locale => /\w{2}/ do
    resources :pages, path: '', only: [:show]
  end

  #match ':locale/:slug' => 'pages#show'
  #match ':locale' => 'locales#change'

  root to: 'pages#show'
end
