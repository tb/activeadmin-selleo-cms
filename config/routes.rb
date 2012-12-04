ActiveadminSelleoCms::Engine.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  match ':slug' => 'pages#show'
end
