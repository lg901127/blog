class FavouritesController < ApplicationController

  def index
    @favourites = current_user.favourite_products
  end

  def create
    @post = Post.find params[:post_id]
    favourite = Favourite.new(post: @post, user: current_user)
    if favourite.save
      redirect_to blog_path(@post), notice: "Added favourite"
    else
      redirect_to blog_path(@post), notice: "Already added"
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @favourite = Favourite.find params[:id]
    @favourite.destroy if can? :destroy, Favourite
    redirect_to blog_path(@post), notice: "Removed from favourites"
  end
end
