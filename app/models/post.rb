class Post < ActiveRecord::Base
  
  include Votable
  
  validates :title, :author, presence: true
  
  belongs_to :author, 
    class_name: "User"
    
  has_many :sub_posts
    
  has_many :subs, 
    through: :sub_posts, 
    source: :sub

  has_many :comments
  
  has_many(
      :top_level_comments,
      -> { where("parent_comment_id IS NULL") },
      class_name: "Comment"
  )
  
  def comments_by_parent_id
    ret = Hash.new { [] }
    
    comments = Comment.order_by_score.where("comments.post_id = ?", self.id)
    
    comments.each do |comment|
      ret[comment.parent_comment_id] += [comment]
    end
    
    ret
  end
  
end
