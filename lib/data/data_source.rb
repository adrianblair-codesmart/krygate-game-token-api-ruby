# frozen_string_literal: true

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Base Class representing a data source
  #
  class DataSource
    def initialize; end

    # Finds an entity by key or by a combination of kind and id or name
    # - the key being an hash containing all the necessary data e.g. the kind and indentifier
    # - the kind being a string representing the kind or table name
    # - the id or name being a string which represents an identifier
    #
    # @param key_or_kind [Hash | String] an indentifier for an entity or kind
    # @param id_or_name [String] an identifying key represented as an id or name
    # @return [Hash | nil] returns an entity Object or nil if not found
    def find(key_or_kind, id_or_name = nil); end

    # Returns a query object for a certain kind from a data store
    # - the kind being a string representing the kind or table name
    # - the query object will have to be run to retrieve the results
    # - the query object acts like a builder object
    #
    # @param kind [String] the kind a query should perform it's lookup on
    # @return [Object] the query object acts like a builder object
    def query(kind); end

    # Inserts entities into a data store
    # - the entities must not already exist
    #
    # @param *entities [Hash] one or more objects to insert.
    # @return [Hash] returns the entities inserted successfully
    def insert(*entities); end

    # Updates entities in a data store
    # - the entities must already exist
    #
    # @param *entities [Hash] one or more objects to update.
    # @return [Hash] returns the entities updated successfully
    def update(*entities); end

    # Saves entities in a data store
    # - an insert will be performed if the entities don't exist
    # - an update will be performed if the entities already exist
    # - also known as an upsert
    #
    # @param *entities [Hash] one or more objects to save.
    # @return [Hash] returns the entities saved successfully
    def save(*entities); end

    # Deletes entities from a data store
    # - the entities themselves can be passed or just the keys of the entities
    #
    # @param *entities_or_keys [Hash] one or more objects to delete.
    # @return [true] returns true if the entities were deleted successfully
    def delete(*entities_or_keys); end
  end
end
