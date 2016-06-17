class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validate :title_length

  def self.search(content)
    where("title ILIKE :word OR body ILIKE :word", {word: "%#{content}%"} )
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
