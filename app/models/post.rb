class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  has_many :ratings, dependent: :destroy
  has_many :rating_users, through: :ratings, source: :user
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  validate :title_length

  def self.search(content)
    where("title ILIKE :word OR body ILIKE :word", {word: "%#{content}%"} )
  end

  def favourite_for(user)
    favourites.find_by_user_id user
  end

  def favourite_by?(user)
    favourites.exists?(user: user)
  end

  def rated_by?(user)
    ratings.exists?(user: user)
  end

  def rate_for(user)
    ratings.find_by_user_id user
  end

  def rated_1_by?(user)
    rated_by?(user) && rate_for(user).star_count == 1
  end

  def rated_2_by?(user)
    rated_by?(user) && rate_for(user).star_count == 2
  end

  def rated_3_by?(user)
    rated_by?(user) && rate_for(user).star_count == 3
  end

  def rated_4_by?(user)
    rated_by?(user) && rate_for(user).star_count == 4
  end

  def rated_5_by?(user)
    rated_by?(user) && rate_for(user).star_count == 5
  end

  private

  def title_length
    if title.length < 7
      errors.add(:title, "Title length must be longer than 7 chars")
    end
  end

  def body_snippet
    body.length > 100 ? body[0...100] + "..." : body
  end

end
