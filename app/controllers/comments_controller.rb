class CommentsController < ApplicationController
  
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    
    @comment = current_user.comments.build(comment_params)
  
    @comment.update_attributes(:entry_id => params.require(:entry_id) )
    
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to :controller => "entries", :action => "show", :id => $current_entry.id
    else
      flash[:danger] = "Comment cannot blank!"
      redirect_to :controller => "entries", :action => "show", :id => $current_entry.id
    end
  end

  def destroy
    @entry  = @comment.entry
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to :controller => "entries", :action => "show", :id => @entry.id
    #redirect_to  root_url
  end

  private


  def comment_params
    params.require(:comment).permit(:content, :picture)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
