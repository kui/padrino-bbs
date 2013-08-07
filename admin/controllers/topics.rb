Bbs::Admin.controllers :topics do
  get :index do
    @title = "Topics"
    @topics = Topic.all
    render 'topics/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'topic')
    @topic = Topic.new
    render 'topics/new'
  end

  post :create do
    @topic = Topic.new(params[:topic])
    if @topic.save
      @title = pat(:create_title, :model => "topic #{@topic.id}")
      flash[:success] = pat(:create_success, :model => 'Topic')
      params[:save_and_continue] ? redirect(url(:topics, :index)) : redirect(url(:topics, :edit, :id => @topic.id))
    else
      @title = pat(:create_title, :model => 'topic')
      flash.now[:error] = pat(:create_error, :model => 'topic')
      render 'topics/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "topic #{params[:id]}")
    @topic = Topic.find(params[:id])
    if @topic
      render 'topics/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'topic', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "topic #{params[:id]}")
    @topic = Topic.find(params[:id])
    if @topic
      if @topic.update_attributes(params[:topic])
        flash[:success] = pat(:update_success, :model => 'Topic', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:topics, :index)) :
          redirect(url(:topics, :edit, :id => @topic.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'topic')
        render 'topics/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'topic', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Topics"
    topic = Topic.find(params[:id])
    if topic
      if topic.destroy
        flash[:success] = pat(:delete_success, :model => 'Topic', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'topic')
      end
      redirect url(:topics, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'topic', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Topics"
    unless params[:topic_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'topic')
      redirect(url(:topics, :index))
    end
    ids = params[:topic_ids].split(',').map(&:strip)
    topics = Topic.find(ids)
    
    if Topic.destroy topics
    
      flash[:success] = pat(:destroy_many_success, :model => 'Topics', :ids => "#{ids.to_sentence}")
    end
    redirect url(:topics, :index)
  end
end
