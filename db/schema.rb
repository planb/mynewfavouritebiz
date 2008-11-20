# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 7) do

  create_table "businesses", :force => true do |t|
    t.column "name",       :string
    t.column "street",     :string
    t.column "suburb",     :string
    t.column "postcode",   :integer,  :limit => 4
    t.column "phone",      :string
    t.column "email",      :string
    t.column "url",        :string
    t.column "permalink",  :string
    t.column "checked",    :boolean,               :default => false
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "features", :force => true do |t|
    t.column "name",         :string
    t.column "permalink",    :string
    t.column "description",  :text
    t.column "created_at",   :datetime
    t.column "updated_at",   :datetime
    t.column "completed_at", :datetime
  end

  create_table "friendships", :force => true do |t|
    t.column "user_id",     :integer,  :null => false
    t.column "friend_id",   :integer,  :null => false
    t.column "created_at",  :datetime
    t.column "accepted_at", :datetime
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.column "server_url", :binary
    t.column "handle",     :string
    t.column "secret",     :binary
    t.column "issued",     :integer
    t.column "lifetime",   :integer
    t.column "assoc_type", :string
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.column "nonce",   :string
    t.column "created", :integer
  end

  create_table "open_id_authentication_settings", :force => true do |t|
    t.column "setting", :string
    t.column "value",   :binary
  end

  create_table "ratings", :force => true do |t|
    t.column "rating",        :integer,                :default => 0
    t.column "review",        :text
    t.column "created_at",    :datetime,                               :null => false
    t.column "rateable_type", :string,   :limit => 15, :default => "", :null => false
    t.column "rateable_id",   :integer,                :default => 0,  :null => false
    t.column "user_id",       :integer,                :default => 0,  :null => false
  end

  add_index "ratings", ["user_id"], :name => "fk_ratings_user"

  create_table "taggings", :force => true do |t|
    t.column "tag_id",        :integer
    t.column "taggable_id",   :integer
    t.column "taggable_type", :string
    t.column "created_at",    :datetime
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], :name => "index_taggings_on_tag_id_and_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.column "name", :string
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.column "login",                     :string
    t.column "permalink",                 :string
    t.column "email",                     :string
    t.column "crypted_password",          :string,   :limit => 40
    t.column "salt",                      :string,   :limit => 40
    t.column "created_at",                :datetime
    t.column "updated_at",                :datetime
    t.column "remember_token",            :string
    t.column "remember_token_expires_at", :datetime
    t.column "admin",                     :boolean,                :default => false
    t.column "suburb",                    :string
    t.column "gender",                    :string
    t.column "identity_url",              :string
  end

end
