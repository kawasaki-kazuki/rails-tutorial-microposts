class User < ApplicationRecord
  # データ保存時に小文字にする
  before_save { self.email = email.downcase }
  # 入力必須かつ50文字以上入力要求
  validates :name,
            presence: true,
            length: { maximum: 50 }
  # アドレスの正規表現パターンを定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # アドレスのルール：
  # #入力必須で255文字上限、正規表現とマッチ、一意となるように
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :microposts

  # フォローしている人、されている人の実装
  # #「dependent: :destroy」であるユーザーが削除されたときに、そのユーザーがフォローしている関係（following_relationships）や、
  # #フォローされている関係（follower_relationships）も一緒に削除されるようにする
  # ##あるuserがフォローしている人
  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  # ##あるuserをフォローしている人
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower

  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているのかどうか
  def following?(other_user)
    following_users.include?(other_user)
  end

  # フォローしているユーザーを取得するメソッド
  def following
    following_users
  end

  # フォロワーを取得するメソッド
  def followers
    follower_users
  end

  def feed_items
    Micropost.where(user_id: following_user_ids + [id])
  end
end
