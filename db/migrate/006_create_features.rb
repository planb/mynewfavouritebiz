class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.column :name,         :string
      t.column :permalink,    :string
      t.column :description,  :text
      t.column :created_at,   :datetime
      t.column :updated_at,   :datetime
      t.column :completed_at, :datetime
    end
  end

  def self.down
    drop_table :features
  end
end
