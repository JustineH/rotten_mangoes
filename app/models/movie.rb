class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :image, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  mount_uploader :image, ImageUploader


  def self.filter(query_title, query_director, query_runtime_in_minutes)
    @movies = Movie.all

    if query_title
      @movies = @movies.where("title LIKE ?", "%#{query_title}%")
    end
    if query_director
      @movies = @movies.where("director LIKE ?", "%#{query_director}%")
    end
    if query_runtime_in_minutes == "under_90"
      @movies = @movies.where("runtime_in_minutes < 90")
    elsif query_runtime_in_minutes == "between_90_and_120"
      @movies = @movies.where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120")
    elsif query_runtime_in_minutes == "over_120"
      @movies = @movies.where("runtime_in_minutes > 120")
    end
    @movies
  end

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
