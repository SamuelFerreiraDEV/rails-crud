class PostsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [ :new, :user_posts ]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post)
    else
      flash.now[:alert] = @post.errors.full_messages.join(" -- ")
      # redirect_to new_post_path
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Post updated."
      redirect_to post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.join(" -- ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = "Post deleted."
      redirect_to posts_path
    end
  end
  def user_posts
    @posts = Post.where(user_id: current_user.id)
    # @posts = Post.includes(:user).where(user: { id: current_user.id })
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_if_not_logged_in
    redirect_to posts_path unless current_user
  end
end
