class Post < ActiveRecord::Base
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
    
    self.comments.each do |comment|
      ret[comment.parent_comment_id] += [comment]
    end
    
    ret
  end
  
end
