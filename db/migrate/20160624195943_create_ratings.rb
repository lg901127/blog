class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_column :posts, :one_star, :integer, default: 0
    add_column :posts, :two_star, :integer, default: 0
    add_column :posts, :three_star, :integer, default: 0
    add_column :posts, :four_star, :integer, default: 0
    add_column :posts, :five_star, :integer, default: 0
  end
end
