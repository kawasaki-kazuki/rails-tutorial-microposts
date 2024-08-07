class User < ApplicationRecord
  #データ保存時に小文字にする
  before_save { self.email = self.email.downcase } 
  #入力必須かつ50文字以上入力要求
  validates :name,
    presence: true,
    length: { maximum: 50 } 
  #アドレスの正規表現パターンを定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :email,
    presence: true, 
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false } #アドレスは
  has_secure_password
end
