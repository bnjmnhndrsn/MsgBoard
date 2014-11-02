class Comment < ActiveRecord::Base
  
  include Votable
  
  validates :content, :author, :post, presence: true
  belongs_to :post
  belongs_to :author, class_name: "User"
  belongs_to :parent_comment, class_name: "Comment"
  has_many( 
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
  
  def child_comments_by_parent_id
    Post.find(self.post_id).comments_by_parent_id
  end
  
end
