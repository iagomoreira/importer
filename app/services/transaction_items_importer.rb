class TransactionItemsImporter < BaseImporter
  self.remote_resource_id = :transaction_items
  self.remote_resource_whitelist = %i(
    transaction_item_id
    transaction_id
    product_id
    quantity
    price
  )
  self.import_model_klass = ::TransactionItem
  self.import_model_id_column = :transaction_item_id
end
