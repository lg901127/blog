class AddStarCountToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :star_count, :integer, default: 0
  end
end
