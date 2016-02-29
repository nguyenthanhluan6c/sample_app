class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @entries = Entry.paginate(page: params[:page]).order('created_at DESC')
  end


  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @entry = Entry.find(params[:id])
    
    if @entry
      $current_entry=@entry      
      @user = @owner  = @entry.user


      @comments =  @entry.comments.paginate(page: params[:page], :per_page => 10).order('created_at DESC')
      
      @can_comment = can_comment?
      if @can_comment    
       @comment  = current_user.comments.build
      end
    end
  end

  def destroy
    @user  = @entry.user
    @entry.destroy
    current_entry =nil;
    flash[:success] = "Entry deleted"
    redirect_to :controller => "users", :action => "show", :id => @user.id
    #redirect_to  root_url
  end

  private


  def entry_params
    params.require(:entry).permit(:title, :body, :picture)
  end

  def correct_user
    @entry = current_user.entries.find_by(id: params[:id])
    redirect_to root_url if @entry.nil?
  end

  def can_comment?
    if logged_in?
       owner_or_following =  ( current_user? @owner )|| (current_user.following? @owner )
       if owner_or_following         
         return true;
       else
         return false;
       end
    else
      return false
    end
  end
end
