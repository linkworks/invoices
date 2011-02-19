class ChangeCompanyInClientToCompanyName < ActiveRecord::Migration
  def self.up
    change_table :clients do |t|
      t.column :company_name, :string
      t.remove :company
    end
  end

  def self.down
    change_table :client do |t|
      t.column :company, :string
      t.remove :company_name
    end
  end
end
