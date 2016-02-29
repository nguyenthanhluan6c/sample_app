class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry  = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @feed_items = @entries = Entry.paginate(page: params[:page]).order('created_at DESC')
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
