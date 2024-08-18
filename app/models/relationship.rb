class Relationship < ApplicationRecord
  # follower:フォローしているuser、followed:フォローされているuser
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end
