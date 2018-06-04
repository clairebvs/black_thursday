module CustomerAnalytics
  def top_buyers(top_customers = 20)
    customer_ids = @parent.invoices.customer_id.keys
    customer_invoices = @parent.invoices.customer_id.values
    customer_totals = calculate_totals_per_customer(customer_invoices)
    customer_ids_and_totals = Hash[customer_ids.zip(customer_totals)]
    ids_for_top_customers = find_ids_for_top_customers(customer_ids_and_totals, top_customers)
    find_customers_from_customer_ids(ids_for_top_customers)
  end

  def top_merchant_for_customer(customer_id)
    invoices_for_customer = @parent.invoices.customer_id[customer_id]
    quantity_for_invoices = calculate_quantity_for_invoices(invoices_for_customer)
    max_items = quantity_for_invoices.compact.max
    index_value_max_items = quantity_for_invoices.index(max_items)
    top_merchant_id = invoices_for_customer[index_value_max_items].merchant_id
    @parent.merchants.find_by_id(top_merchant_id)
  end

  def one_time_buyers
    invoices_per_customer = @parent.invoices.customer_id.values
    customers_with_single_purchase(invoices_per_customer)
  end

  def one_time_buyers_top_item
    hash = Hash.new(0)
    j = one_time_buyers.map do |customer|
      customer_id = customer.id
      invoice = @parent.invoices.find_all_by_customer_id(customer_id)
      invoice_id = invoice.first.id
      invoice_items = @parent.invoice_items.find_all_by_invoice_id(invoice_id)
      invoice_items.each do |invoice_item|
        x = invoice_item.item_id
         hash[x] = hash[x] + invoice_item.quantity.to_i
      end
    end
    highest_quantity_index = hash.values.index(hash.values.max)
    item_id_highest_quantity = hash.keys[highest_quantity_index]
    @parent.items.find_by_id(item_id_highest_quantity)
  end

  def items_bought_in_year(customer_id, year)
    customer_invoices = @parent.invoices.find_all_by_customer_id(customer_id)
    customer_invoice_items = find_all_customer_invoice_items(customer_invoices, year)
    customer_invoice_items.map do |invoice_item|
      item = invoice_item.item_id
      @parent.items.find_by_id(item)
    end.flatten
  end

  def highest_volume_items(customer_id)
    invoices_per_customer = @parent.invoices.find_all_by_customer_id(customer_id)
    invoice_items_per_customer = find_invoice_items_per_customer(invoices_per_customer)
    item_id_quantities = find_item_id_quantities(invoice_items_per_customer)
    item_id_quantities.keep_if do |item_id|
      item_id_quantities[item_id] == item_id_quantities.values.max
    end
    item_id_quantities.keys.map do |item_id|
      @parent.items.find_by_id(item_id)
    end
  end

  def customers_with_unpaid_invoices
    unpaid_invoices = @parent.invoices.all.map do |invoice|
      invoice_id = invoice.id
      invoice unless invoice_paid_in_full?(invoice_id)
    end.compact
    find_customers_with_unpaid_invoices(unpaid_invoices)
  end

  def find_paid_invoices
    @parent.invoices.all.map do |invoice|
      invoice_id = invoice.id
      invoice if invoice_paid_in_full?(invoice_id)
    end.compact
  end

  def best_invoice_by_revenue
    paid_invoices = find_paid_invoices
    invoice_items_by_invoices = find_invoice_items_by_invoices(paid_invoices)
    revenue_by_invoice = find_revenue_by_invoice(invoice_items_by_invoices)
    find_invoice_of_max_value(revenue_by_invoice, paid_invoices)
  end

  def best_invoice_by_quantity
    paid_invoices = find_paid_invoices
    invoice_items_by_invoices = find_invoice_items_by_invoices(paid_invoices)
    revenue_by_invoice = find_quantity_by_invoice(invoice_items_by_invoices)
    find_invoice_of_max_value(revenue_by_invoice, paid_invoices)
  end
end
