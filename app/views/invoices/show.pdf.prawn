# Title
pdf.text "#{t('.invoice')} ##{@invoice.id.to_s}", :size => 25

# Client info
pdf.text @invoice.client.name
pdf.text @invoice.client.company_name
pdf.text @invoice.client.address

#pdf.draw_text "#{t('.created_at')}: #{l(@invoice.created_at, :format => :short)}", :at => [pdf.bounds.width / 2, pdf.bounds.height - 30]

# Our company info
pdf.float do
  pdf.bounding_box [0, pdf.bounds.top - 5], :width => pdf.bounds.width do
    pdf.text @invoice.client.company.name, :size => 20, :align => :right
  end
end

pdf.move_down 20

# Items
header = [t('.quantity'), t('.description'), t('.unit_cost'), t('.discount'), t('.total')]
items = @invoice.items.collect do |item|
  [item.quantity, item.description, number_to_currency(item.unit_cost), item.discount.to_s + '%', number_to_currency(item.total_price)]
end

pdf.table items, :border_style => :grid, 
                 :headers => header, 
                 :width => pdf.bounds.width, 
                 :row_colors => %w{cccccc eeeeee},
                 :align => { 0 => :right, 1 => :left, 2 => :right, 3 => :right, 4 => :right }

pdf.move_down 10

# Total
pdf.text "#{t('.total')} #{number_to_currency(@invoice.total)}", :style => :bold, :align => :right, :size => 20


# Terms
if @invoice.terms != ''
  pdf.move_down 20
  pdf.text t('.terms'), :size => 18
  pdf.text @invoice.terms
end

# Notes
if @invoice.notes != ''
  pdf.move_down 20
  pdf.text t('.notes'), :size => 18
  pdf.text @invoice.notes
end

# Footer
pdf.draw_text "#{t('.generated_at')} #{l(Time.now, :format => :short)}", :at => [0, 0]