class CreateInfluencers < ActiveRecord::Migration[5.1]
  def change
    create_table :influencers do |t|
      t.string :full_name
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :youtube

      t.timestamps
    end
  end
end
