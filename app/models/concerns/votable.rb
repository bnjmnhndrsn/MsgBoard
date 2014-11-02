module Votable
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :votable
  
    def score
      self.votes.sum(:value)
    end
  end
  
  module ClassMethods
    def order_by_score
      table = self.to_s.tableize
      join = <<-SQL
      LEFT OUTER JOIN 
        votes
      ON 
        #{table}.id = votes.votable_id
      AND
        votes.votable_type = '#{self.to_s}'
      SQL
      self
        .joins(join)
        .group("#{table}.id")
        .order("SUM(COALESCE(votes.value, 0)) DESC")
    end
  end
  
end