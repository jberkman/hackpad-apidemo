Hpjsdemo::Application.routes.draw do
  resources :pads do
    resource 'embed', :only => :show do
      get 'nosig'
      get 'noemail'
    end
    resources 'revisions', :only => [ :index, :show ]
  end
end
