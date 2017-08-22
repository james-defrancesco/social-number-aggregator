class AddCachableNumbersToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :ig, :string
    add_column :influencers, :tw, :string
    add_column :influencers, :yt, :string
  end
end
