# frozen_string_literal: true

require 'google/cloud/datastore'

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  #  Class representing a data source using the google cloud datastore API
  #
  # @attr_reader [Google::Cloud::Datastore] data_store the data source the context will use
  class DataSourceParser
    include App::Import[:data_store]

    # @param [Object] data_store the data store the context will use
    #
    # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
    def initialize(data_store: nil)
      super
      @data_store = data_store
    end

    # Converts a hash to an entity
    #
    # @param item [Hash] hash item to convert
    # @return [Object] returns the converted hash as an entity
    def hash_to_entity(item); end

    # Converts an entity to a hash
    #
    # @param item [Object] entity item to convert
    # @return [Hash] returns the converted entity as a hash
    def entity_to_hash(item); end

    # Converts a hash to a key
    #
    # @param item [Hash] hash item to convert
    # @return [Object] returns the converted hash as a key
    def convert_to_key(item); end

    # Converts an array of hashes to entities
    #
    # @param items [Array<Hash>] an array of hashes to be converted to entities
    # @return [Array<Object>] returns the converted entities
    # @see Data::DataSourceParser#hash_to_entity Data::DataSourceParser#hash_to_entity
    def hashes_to_entities(items)
      items.map { |item| hash_to_entity(item) }
    end

    # Converts an array of entities to hashes
    #
    # @param items [Array<Object>] an array of entities to be converted to hashes
    # @return [Array<Hash>] returns the converted hashes
    # @see Data::DataSourceParser#entity_to_hash Data::DataSourceParser#entity_to_hash
    def entities_to_hashes(items)
      items.map { |item| entity_to_hash(item) }
    end

    # Converts an array of hashes to keys
    #
    # @param items [Array<Hash>] an array of hashes to be converted to keys
    # @return [Array<Object>] returns the converted keys
    # @see Data::DataSourceParser#convert_to_key Data::DataSourceParser#convert_to_key
    def convert_to_keys(items)
      items.map { |item| convert_to_key(item) }
    end
  end
end
