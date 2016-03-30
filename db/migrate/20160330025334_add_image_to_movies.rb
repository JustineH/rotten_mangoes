class AddImageToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :image, :string
    remove_column :movies, :poster_image_url
  end
end
