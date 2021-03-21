# frozen_string_literal: true

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

    # Finds an model by key or by a combination of kind and id or name
    # - the key being an object containing all the necessary data e.g. the kind and identifier
    # - the kind being a string representing the kind or table name
    # - the id or name being a string which represents an identifier
    #
    # @param key_or_kind [Object, String] an identifier for an model or kind
    # @param id_or_name [String] an identifying key represented as an id or name
    # @return [Object, nil] returns an model Object or nil if not found
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

    # Runs a query object on a data source
    #
    # @param query [Object] the query to be run on the data source
    # @return [Object] the query result object
    def run(query)
      @data_source.run(query)
    end

    # Inserts models into a data source
    # - the models must not already exist
    #
    # @param models [#to_h] one or more objects which can be converted to hashes
    # @return [Array<Hash>] returns the models inserted successfully
    def insert(*models)
      @data_source.insert(convert_models_to_hashes(models))
    end

    # Updates models in a data source
    # - the models must already exist
    #
    # @param models [#to_h] one or more objects which can be converted to hashes
    # @return [Array<Hash>] returns the models updated successfully
    def update(*models)
      @data_source.update(convert_models_to_hashes(models))
    end

    # Saves models in a data source
    # - an insert will be performed if the models don't exist
    # - an update will be performed if the models already exist
    # - also known as an upsert
    #
    # @param models [#to_h] one or more objects which can be converted to hashes
    # @return [Array<Hash>] returns the models saved successfully
    def save(*models)
      @data_source.save(convert_models_to_hashes(models))
    end

    # Deletes models from a data source
    # - the models themselves can be passed or just the keys of the models
    #
    # @param models [#to_h] one or more objects which can be converted to hashes
    # @return [true] returns true if the models were deleted successfully
    def delete(*models)
      @data_source.delete(convert_models_to_hashes(models))
    end

    # Convert models to hashes
    #
    # @param models [#to_h] one or more objects which can be converted to hashes
    # @return [Array<Hash>] returns an array of hashes which represent the models
    def convert_models_to_hashes(*models)
      models.flatten!

      models.map! do |model|
        raise TypeError, "#{model.inspect} cannot be converted to a hash." unless model.respond_to? :to_h
        model.to_h
      end
    end
  end
end

# takes the full hash and converts it to the