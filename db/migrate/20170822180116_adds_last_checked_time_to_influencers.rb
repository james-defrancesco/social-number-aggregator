class AddsLastCheckedTimeToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :last_checked, :datetime
  end
end
