class CategoriesImporter < BaseImporter
  self.remote_resource_id = :categories
  self.remote_resource_whitelist = %i(
    name
    description
    category_id
  )
  self.import_model_klass = ::Category
  self.import_model_id_column = :category_id
end
