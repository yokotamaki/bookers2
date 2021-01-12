class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy#ユーザとフォローいている人の紐付け
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy#ユーザとフォローされている人の紐付け
  has_many :following_user, through: :follower, source: :followed#自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower#自分がフォローされている人

  def follow(user_id)#フォローする
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)#フォローを外す
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def User.search(search,keyword)
    if search == 'perfect_match'
      @user = User.where("name LIKE?","#{keyword}")
    elsif search == 'partial_match'
      @user = User.where("name LIKE(?)","%#{keyword}%")
    elsif search == 'forward_match'
      @user = User.where("name LIKE(?)","#{keyword}%")
    elsif search == 'backward_match'
      @user = User.where("name LIKE(?)","%#{keyword}")
    else
      @user = User.all
    end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  def prefecture_name=(prefecture_name)
    self.prefecture_code=JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  attachment :profile_image

  validates :name, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true

end
