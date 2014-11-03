class PostsController < ApplicationController
 include VotableActions
  
  before_action :require_login, except: :show
  
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    redirect_to subs_path unless user_is_creator?(@post, :author_id)
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to subs_path unless user_is_creator?(@post, :author_id)
  end

  def destroy
    post = Post.find(params[:id])
    redirect_to subs_path unless user_is_creator?(post, :author_id)
    post.destroy
    redirect_to subs_url
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end
end
