# frozen_string_literal: true

require './lib/app/app_container'

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Base Class representing a data context
  #
  class DataContext
    include App::Import['data_source']

    # @see https://dry-rb.org/gems/dry-auto_inject/0.6/how-does-it-work/ dry-auto_inject
    def initialize(data_source: nil)
      super()

      @data_source = data_source
    end

    # Finds an entity by key or by a combination of kind and id or name.
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

    def query(kind)
      @data_source.query(kind)
    end

    def insert(*entities)
      @data_source.insert(*entities)
    end

    def update(*entities)
      @data_source.update(*entities)
    end

    def save(*entities)
      @data_source.save(*entities)
    end

    def delete(*entities_or_keys)
      @data_source.delete(*entities_or_keys)
    end
  end
end
