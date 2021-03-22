# frozen_string_literal: true

# Namespace for data related modules and classes
# @author Adrian Blair
module GameToken
  # Base Class representing a data context
  #
  # @attr_reader [Data::DataSource] data_source the data source the context will use
  # @attr_reader [String] data_kind the kind of the entity to be stored
  class DataAccessObject < Data::DataAccessObject
    # @param [Data::DataSource] data_source the data source the context will use
    #
    # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
    def initialize(data_source: nil)
      super(data_kind: 'GameToken', data_source: data_source)
    end

    # Inserts models into a data source
    # - the models must not already exist
    #
    # @param models [Array<#to_h>] one or more objects which can be converted to hashes
    # @raise [App::CustomErrors::ItemAlreadyExistsError] raised when the item already exists
    # @return [Array<Hash>] returns the models inserted successfully
    def insert(models)
      existing_models = find_all_by_name_and_key(models)
      
      raise App::CustomErrors::ItemAlreadyExistsError, 'Game Token already exists and cannot be inserted.' unless existing_models.blank?

      @data_source.insert(convert_models_to_hashes(models)) if existing_models.blank?
    end

    def find_all_by_name_and_key(models)
      query_obj = query

      models.each { |model| query_obj.where('token_name', '=', model.token_name) }

      run(query_obj)
    end
  end
end