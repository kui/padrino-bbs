Bbs::App.controllers :topics do


  get :index do
    @topics = Topic.all(:order => 'created_at desc')
    render 'topics/index'
  end

  get :show, :with => :id do
    @topic = Topic.find_by_id(params[:id])

    halt 404 unless @topic

    render 'topics/show'
  end

  get :new do

  end

  post :create do

  end

  get :edit do

  end

  post :update do

  end

end
