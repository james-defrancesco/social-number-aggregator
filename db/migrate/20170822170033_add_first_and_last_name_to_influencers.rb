class AddFirstAndLastNameToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :first_name, :string
    add_column :influencers, :last_name, :string
  end
end
