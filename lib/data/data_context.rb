# frozen_string_literal: true

require './lib/app/app_container'

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Base Class representing a data context
  #
  # @attr_reader [Data::DataSource] data_source the data source the context will use
  class DataContext
    include App::Import['data_source']

    # @param [Data::DataSource] data_source the data source the context will use
    #
    # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
    def initialize(data_source: nil)
      @data_source = data_source
    end

    # Finds an entity by key or by a combination of kind and id or name
    # - the key being an object containing all the necessary data e.g. the kind and indentifier
    # - the kind being a string representing the kind or table name
    # - the id or name being a string which represents an identifier
    #
    # @param key_or_kind [Object | String] an indentifier for an entity or kind
    # @param id_or_name [String] an identifying key represented as an id or name
    # @return [Object | nil] returns an entity Object or nil if not found
    def find(key_or_kind, id_or_name = nil)
      @data_source.find(key_or_kind, id_or_name)
    end

    # Returns a query object for a certain kind from a data source
    # - the kind being a string representing the kind or table name
    # - the query object will have to be run to retrieve the results
    # - the query object acts like a builder object
    #
    # @param kind [String] the kind a query should perform it's lookup on
    # @return [Object] the query object acts like a builder object
    def query(kind)
      @data_source.query(kind)
    end

    # Inserts entities into a data source
    # - the entities must not already exist
    #
    # @param *entities [Object] one or more objects to insert.
    # @return [Object] returns the entities inserted successfully
    def insert(*entities)
      @data_source.insert(*entities)
    end

    # Updates entities in a data source
    # - the entities must already exist
    #
    # @param *entities [Object] one or more objects to update.
    # @return [Object] returns the entities updated successfully
    def update(*entities)
      @data_source.update(*entities)
    end

    # Saves entities in a data source
    # - an insert will be performed if the entities don't exist
    # - an update will be performed if the entities already exist
    # - also known as an upsert
    #
    # @param *entities [Object] one or more objects to save.
    # @return [Object] returns the entities saved successfully
    def save(*entities)
      @data_source.save(*entities)
    end

    # Deletes entities from a data source
    # - the entities themselves can be passed or just the keys of the entities
    #
    # @param *entities_or_keys [Object] one or more objects to delete.
    # @return [true] returns true if the entities were deleted successfully
    def delete(*entities_or_keys)
      @data_source.delete(*entities_or_keys)
    end
  end
end
