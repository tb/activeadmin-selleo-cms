ActiveadminSelleoCms::Engine.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  match '(:locale)/:slug' => 'pages#show'

  root to: 'pages#show'
end
