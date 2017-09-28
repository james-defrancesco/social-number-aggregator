class AddCompanyToInfluencers < ActiveRecord::Migration[5.1]
  def change
    add_column :influencers, :company, :string
  end
end
