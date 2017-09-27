class LikesController < ApplicationController

  after_action :verify_authorized

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    authorize like
    if like.save
      # Add code to generate a success flash and redirect to @bookmark
      flash[:notice] = "Bookmark Liked!"
      redirect_to @bookmark.topic
    else
      # Add code to generate a failure flash and redirect to @bookmark
      flash[:alert] = "There was an error liking this bookmark. Please try again."
      redirect_to @bookmark.topic
    end
  end

  def destroy
    # Get the bookmark from the params
    @bookmark = Bookmark.find(params[:bookmark_id])
    # Find the current user's like with the ID in the params
    like = current_user.likes.find(params[:id])

    authorize like
    if like.destroy
      # Flash success and redirect to @bookmark
      flash[:notice] = "Bookmark was unliked."
      redirect_to @bookmark.topic
    else
      # Flash error and redirect to @bookmark
      flash[:alert] = "There was an error Unliking this bookmark.  Please try again."
      redirect_to @bookmark.topic
    end
  end
end
