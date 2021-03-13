# frozen_string_literal: true

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Base Class representing a data access object
  #
  # @attr_reader [Data::DataSource] data_source the data source the context will use
  # @attr_reader [String] data_kind the kind of the entity to be stored
  class DataAccessObject < Data::DataContext
    attr_reader :data_kind

    # @param [Data::DataSource] data_source the data source the context will use
    # @param data_kind [String] the kind of the entity to be stored
    #
    # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
    def initialize(data_kind:, data_source: nil)
      super(data_source: data_source)
      @data_kind = data_kind
    end

    # Finds an entity by key or by a combination of kind and id or name
    # - the key being an object containing all the necessary data e.g. the kind and indentifier
    # - the kind being a string representing the kind or table name
    # - the id or name being a string which represents an identifier
    #
    # @param key_or_kind [Object, String] an indentifier for an entity or kind
    # @param id_or_name [String] an identifying key represented as an id or name
    # @return [Object, nil] returns an entity Object or nil if not found
    def find(id_or_name = nil)
      @data_source.find(@data_kind, id_or_name)
    end

    # Returns a query object for a certain kind from a data source
    # - the kind being a string representing the kind or table name
    # - the query object will have to be run to retrieve the results
    # - the query object acts like a builder object
    #
    # @param kind [String] the kind a query should perform it's lookup on
    # @return [Object] the query object acts like a builder object
    def query
      @data_source.query(@data_kind)
    end
  end
end
