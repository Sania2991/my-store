 Rails.application.routes.draw do
  
  #get 'controller(/:action(/:id))(.:format)'
  #match ':controller(/:action(/:id))(.:format)', via: [:get, :post] 
  
  resources :items do
    get :upvote, on: :member
    # on: :member  -  Это означает, что метод upvote будет доступен для всех item.id
    # :member - значит, что применяется к конкретому ресурсу
    get :expensive, on: :collection
    # Благодаря :collection мы можем в адресной строке прописать: ../items/expensive
    # :collection - применяется ко всей коллекции.
  end
  #передаем блок, внутри которого объясним нашему приложению, 
  #  ,что экшн upvote должен быть доступен для ресурса items

end 

