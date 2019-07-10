Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #user
  scope 'user' do
    get '/get', :to=>  'users#showUser'
    post '/add', :to=> 'users#createUser'
    post '/login', :to=>'auth_user#login'
    get '/getall', :to=>'users#getAllUsers'
    post '/edit', :to=>'users#editUser'
    post '/editpass', :to=>'users#editPassword'
    get '/delete', :to=>'users#deleteUser'
  end

  scope 'post' do
    post '/add', :to=> 'posts#createPost'
    get '/get', :to=> 'posts#getAllPost'
    get '/get/:id', :to=> 'posts#getPostById'
    get '/getuserpost', :to=>'posts#getPostByUser'
    post '/edit/:id', :to=>'posts#editPostByUser'
    get 'delete/:id', :to=>'posts#deletePost'
  end

end
