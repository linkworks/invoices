class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.text :notes
      t.text :term
      t.string :status
      t.integer :client_id

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
