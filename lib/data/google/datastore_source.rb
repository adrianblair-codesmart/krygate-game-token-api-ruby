# frozen_string_literal: true

require 'google/cloud/datastore'

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Namespace for Google related modules and classes
  # @author Adrian Blair
  module Google
    #  Class representing a data source using the google cloud datastore API
    #
    # @attr_reader [Google::Cloud::Datastore] data_store the data source the context will use
    class DatastoreSource < Data::DataSource
      include App::Import[:data_store]
      include App::Import[:data_source_parser]

      # @param [Google::Cloud::Datastore] data_store the data store the context will use
      #
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore.html Google Cloud Datastore
      # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
      def initialize(data_store: nil, data_source_parser: nil)
        super
        @data_store = data_store
        @data_source_parser = data_source_parser
      end

      # Finds an entity by key or by a combination of kind and id or name
      # - the key being an hash containing all the necessary data e.g. the kind and indentifier
      # - the kind being a string representing the kind or table name
      # - the id or name being a string which represents an identifier
      #
      # @param key_or_kind [Hash, String] an indentifier for an entity or kind
      # @param id_or_name [String] an identifying key represented as an id or name
      # @return [Hash, nil] returns an entity Object or nil if not found
      def find(key_or_kind, id_or_name = nil)
        @data_store.find(key_or_kind, id_or_name)
      end

      # Returns a query object for a certain kind from a data store
      # - the kind being a string representing the kind or table name
      # - the query object will have to be run to retrieve the results
      # - the query object acts like a builder object
      #
      # @param kind [String] the kind a query should perform it's lookup on
      # @return [Object] the query object acts like a builder object
      def query(kind)
        @data_store.query(kind)
      end

      # Inserts entities into a data store
      # - the entities must not already exist
      #
      # @param entities [Array<Hash>] one or more objects to insert.
      # @return [Array<Hash>] returns the entities inserted successfully
      def insert(entities)
        @data_store.insert(entities)
      end

      # Updates entities in a data store
      # - the entities must already exist
      #
      # @param entities [Array<Hash>] one or more objects to update.
      # @return [Array<Hash>] returns the entities updated successfully
      def update(entities)
        @data_store.update(entities)
      end

      # Saves entities in a data store
      # - an insert will be performed if the entities don't exist
      # - an update will be performed if the entities already exist
      # - also known as an upsert
      #
      # @param entities [Array<Hash>] one or more objects to save.
      # @return [Array<Hash>] returns the entities saved successfully
      def save(entities)
        @data_store.save(entities)
      end

      # Deletes entities from a data store
      # - the entities themselves can be passed or just the keys of the entities
      #
      # @param entities [Array<Hash>] one or more objects to delete.
      # @return [true] returns true if the entities were deleted successfully
      def delete(entities)
        @data_store.delete(entities)
      end
    end
  end
end
