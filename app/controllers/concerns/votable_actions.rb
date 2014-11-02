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
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
    
    def vote(value)
      @votable = find_votable
      @votable.votes.create(value: value, user: current_user)
      redirect_to @votable
    end
end