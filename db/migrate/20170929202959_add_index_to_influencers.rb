class AddIndexToInfluencers < ActiveRecord::Migration[5.1]
  def change
      add_index :influencers, [:first_name, :last_name, :company]
  end
end
