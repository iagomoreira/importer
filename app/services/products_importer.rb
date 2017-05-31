class ProductsImporter < BaseImporter
  self.remote_resource_id = :products
  self.remote_resource_whitelist = %i(
    product_id
    name
    description
  )
  self.import_model_klass = ::Product
  self.import_model_id_column = :product_id
end
