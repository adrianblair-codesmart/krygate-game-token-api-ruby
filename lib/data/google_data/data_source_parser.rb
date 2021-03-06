# frozen_string_literal: true

require 'google/cloud/datastore'
require 'byebug'

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Namespace for Google related modules and classes
  # @author Adrian Blair
  module GoogleData
    #  Class representing a data source using the google cloud datastore API
    #
    # @attr_reader [Google::Cloud::Datastore] data_store the data source the context will use
    class DataSourceParser < Data::DataSourceParser
      # @param [Google::Cloud::Datastore] data_store the data store the context will use
      #
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore.html Google Cloud Datastore
      # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
      def initialize(data_store: nil)
        super(data_store: data_store)
      end

      # Converts a hash to an entity
      # - this is a specific google datastore entity type
      #
      # @param item [Hash] hash item to convert
      # @return [Google::Cloud::Datastore::Entity] returns the converted hash as an entity
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore/Entity.html Google::Cloud::Datastore::Entity
      def hash_to_entity(item)
        @data_store.entity item[:ds_kind], item[item[:ds_identifier]] do |t|
          item.each do |key, value|
            t[key] = value if key != :ds_identifier && key != :ds_kind && key != :id
          end
        end
      end

      # Converts an entity to a hash
      # - this is a specific google datastore entity type
      #
      # @param item [Google::Cloud::Datastore::Entity] entity item to convert
      # @return [Hash] returns the converted entity as a hash
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore/Entity.html Google::Cloud::Datastore::Entity
      def entity_to_hash(item)
        item_hash = item.properties.to_h
        item_hash[:id] = item.key.name
        item_hash
      end

      # Converts a hash to a key
      # - this is a specific google datastore key type
      #
      # @param item Hash<ds_kind, id> hash item to convert
      # @return [Array<Google::Cloud::Datastore::Key] returns the converted hash as a key
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore/Key.html Google::Cloud::Datastore::Key
      # @see Data::Google::DatastoreSource#convert_to_key Data::Google::DatastoreSource#convert_to_key
      def convert_to_key(item)
        key = data_store.key item[:kind], item[:id]
      end

      # Converts an array of hashes to entities
      # - this is a specific google datastore entity type
      #
      # @param items [Array<Hash>] an array of hashes to be converted to entities
      # @return [Array<Google::Cloud::Datastore::Entity>] returns the converted entities
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore/Entity.html Google::Cloud::Datastore::Entity
      # @see Data::Google::DatastoreSource#hash_to_entity Data::Google::DatastoreSource#hash_to_entity
      def hashes_to_entities(items)
        items.map { |item| hash_to_entity(item) }
      end

      # Converts an array of entities to hashes
      # - this is a specific google datastore entity type
      #
      # @param items [Array<Google::Cloud::Datastore::Entity>] an array of entities to be converted to hashes
      # @return [Array<Hash>] returns the converted hashes
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore/Entity.html Google::Cloud::Datastore::Entity
      # @see Data::Google::DatastoreSource#entity_to_hash Data::Google::DatastoreSource#entity_to_hash
      def entities_to_hashes(items)
        items.map { |item| entity_to_hash(item) }
      end

      # Converts an array of hashes to an array of keys
      # - this is a specific google datastore key type
      #
      # @param items [Array<Hash<String, String>>] an array containing Hash<ds_kind, id>
      # @return [Array<Google::Cloud::Datastore::Key>] returns the converted hash as a key
      # @see https://googleapis.dev/ruby/google-cloud-datastore/latest/Google/Cloud/Datastore/Key.html Google::Cloud::Datastore::Key
      # @see Data::Google::DatastoreSource#convert_to_key Data::Google::DatastoreSource#convert_to_key
      def convert_to_keys(items)
        items.map { |item| convert_to_key(item) }
      end
    end
  end
end
