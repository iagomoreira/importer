class TransactionsImporter < BaseImporter
  self.remote_resource_id = :transactions
  self.remote_resource_whitelist = %i(
    transaction_id
    customer_id
    staff_id
    payment_status
    discount_value
    total
    barcode
    date_time
  )
  self.import_model_klass = ::Transaction
  self.import_model_id_column = :transaction_id
end
