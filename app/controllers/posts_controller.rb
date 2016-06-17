class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in" unless user_signed_in?
  end
  def posts
    # @posts = Post.order("created_at")
    @posts = Post.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def create
    post_params = params.require(:post).permit(:title, :body)
    @post = Post.new post_params
    if @post.save
      redirect_to blog_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    post_params = params.require(:post).permit(:title, :body)
    if @post.update post_params
      redirect_to blog_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

  def search
    if params[:search]
      # @posts = Post.all.search(params[:search][0])
      @posts = Post.all.search(params[:search][0]).paginate(:page => params[:page], :per_page => 10)
    else
      # @posts = Post.all
      @posts = Post.paginate(:page => params[:page], :per_page => 10)
    end
  end

end
