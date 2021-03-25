# frozen_string_literal: true

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Base Class representing a data access object
  #
  # @attr_reader [Data::DataSource] data_source the data source the context will use
  # @attr_reader [String] data_kind the kind of the model to be stored
  class DataAccessObject < Data::DataContext
    attr_reader :data_kind

    # @param [Data::DataSource] data_source the data source the context will use
    # @param data_kind [String] the kind of the model to be stored
    #
    # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
    def initialize(data_kind:, data_source: nil)
      super(data_source: data_source)
      @data_kind = data_kind
    end

    # Finds an model by key or by a combination of kind and id or name
    # - the key being an object containing all the necessary data e.g. the kind and identifier
    # - the kind being a string representing the kind or table name
    # - the id or name being a string which represents an identifier
    #
    # @param id_or_name [String] an identifying key represented as an id or name
    # @return [Object, nil] returns an model Object or nil if not found
    def find(id_or_name = nil)
      super(@data_kind, id_or_name)
    end

    # Returns a query object for a certain kind from a data source
    # - the kind being a string representing the kind or table name
    # - the query object will have to be run to retrieve the results
    # - the query object acts like a builder object
    #
    # @return [Object] the query object acts like a builder object
    def query
      super(@data_kind)
    end

    # Deletes entities matching the kinds and ids from a data source
    #
    # @param ids [Array<string>] an array containing ids of items to be deleted
    # @return [true] returns true if the models were deleted successfully
    def delete(ids)
      kinds_and_ids = ids.map { |id| { kind: @data_kind, id: id } }
      super(kinds_and_ids)
    end
  end
end
