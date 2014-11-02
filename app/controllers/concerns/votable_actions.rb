module VotableActions
  extend ActiveSupport::Concern
  
  def upvote
    vote(1)
  end
  
  def downvote
    vote(-1)
  end
  
  private
    def find_votable
      params[:controller].classify.constantize.find(params[:id])
    end
    
    def vote(value)
      @votable = find_votable
      @votable.votes.create(value: value, user: current_user)
      redirect_to request.referrer
    end
end