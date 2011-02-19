class ChangeNameOfTermToTermsInInvoice < ActiveRecord::Migration
  def self.up
    change_table :invoices do |t|
      t.column :terms, :text
      
      Invoice.all.each do |invoice|
        invoice.terms = invoice.term
      end
      
      t.remove :term
    end
  end

  def self.down
    t.column :term, :text
    
    Invoice.all.each do |invoice|
      invoice.term = invoice.terms
    end
    
    t.remove :terms
  end
end
