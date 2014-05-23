class Change < ActiveRecord::Migration
  def self.up
  	execute "SELECT setval('groups_id_seq', 1000)"
  end
end
