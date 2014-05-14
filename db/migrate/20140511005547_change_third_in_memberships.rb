class ChangeThirdInMemberships < ActiveRecord::Migration
  def change
  	rename_column :memberships, :thid, :third
  end
end
