class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.column :name,       :string
      t.column :street,     :string
      t.column :suburb,     :string
      t.column :postcode,   :integer, :limit => 4
      t.column :phone,      :string
      t.column :email,      :string
      t.column :url,        :string
      t.column :permalink,  :string
      t.column :checked,    :boolean, :default => 0
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :businesses
  end
end
