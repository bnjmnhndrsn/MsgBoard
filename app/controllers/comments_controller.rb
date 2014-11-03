class CommentsController < ApplicationController
  include VotableActions
  
  before_action :require_login, except: :show
  
  def show
    @comment = Comment.find(params[:id])
    render :show
  end
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    post_id = params[:comment][:post_id]
    if @comment.save
      redirect_to params[:comment][:redirect]
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to request.referrer
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to params[:comment][:redirect]
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to request.referrer
    end
  end

  def destroy
    comment = Comment.find(:id)
    post_id = comment.post_id
    comment.destroy
    redirect_to request.referrer
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
