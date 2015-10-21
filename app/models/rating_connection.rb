class RatingConnection < ActiveRecord::Base
  belongs_to :rater, :class_name => :Account
  belongs_to :ratee, :class_name => :Account
end
