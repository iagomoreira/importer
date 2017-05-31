class BaseImporter
  class << self
    def call
      collector = Collector.new(remote_resource_id: @remote_resource_id)
      parser = Parser.new(whitelist: @remote_resource_whitelist)
      creator = Creator.new(model_klass: @import_model_klass, id_column: @import_model_id_column)

      Importer.new(collector: collector, parser: parser, creator: creator).call
    end

    private
    attr_writer(
      :remote_resource_id,
      :remote_resource_whitelist,
      :import_model_klass,
      :import_model_id_column
    )
  end

  class Importer
    def initialize(collector:, parser:, creator:)
      @collector = collector
      @parser = parser
      @creator = creator
    end

    def call
      records = @collector.call

      records.each do |record|
        parsed_record = @parser.call(record)
        @creator.call(parsed_record)
      end
    end
  end

  class Collector
    def initialize(remote_resource_id:)
      @remote_resource_id = remote_resource_id
    end

    def call
      page_number = 1
      records = []

      loop do
        new_records = fetch_records(page_number)
        records.concat(new_records)
        page_number += 1

        break if new_records.empty?
      end

      records
    end

    private

    def fetch_records(page_number)
      Epos::Client.public_send(@remote_resource_id, page: page_number)
    end
  end

  class Parser
    def initialize(whitelist:)
      @whitelist = whitelist
    end

    def call(params)
      parsed_params = params.transform_keys(&:underscore).with_indifferent_access
      parsed_params
        .slice(*@whitelist)
        .merge(data: parsed_params)
    end
  end

  class Creator
    def initialize(model_klass:, id_column:)
      @model_klass = model_klass
      @id_column = id_column
    end

    def call(record)
      create_or_update_resource(record)
    end

    def create_or_update_resource(params)
      record = find_or_initialize_record(params)
      record.update_attributes!(params)
      record
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.info(e.message)
    end

    def find_or_initialize_record(params)
      @model_klass.find_or_initialize_by(@id_column => params[@id_column])
    end
  end
end
