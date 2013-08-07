Bbs::App.controllers :session do
  get :new do
    render "session/new", nil, :layout => false
  end

  post :create do
    if account = Account.authenticate(params[:email], params[:password])
      set_current_account(account)
      redirect url(:topics, :index)
    else
      params[:email], params[:password] = h(params[:email]), h(params[:password])
      flash[:error] = pat('login.error')
      redirect url(:session, :new)
    end
  end

  get :destroy do
    set_current_account(nil)
    redirect url(:topics, :index)
  end
end
