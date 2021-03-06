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
    # @param models [Array<App::GameToken::Model>] one or more objects which can be converted to hashes
    # @raise [App::CustomErrors::ItemAlreadyExistsError] raised when the item already exists
    # @return [Array<Hash>] returns the models inserted successfully
    def insert(models)
      existing_models = find_all_by_name(models)

      unless existing_models.blank?
        raise App::CustomErrors::ItemAlreadyExistsError, 'Game Token already exists and cannot be inserted.'
      end

      super(convert_models_to_hashes(models))
    end

    # Updates models in a data source
    # - the models must already exist
    #
    # @param models [Array<App::GameToken::Model>] one or more objects which can be converted to hashes
    # @raise [App::CustomErrors::ItemDoesNotExistError] raised when the item does not exist
    # @return [Array<Hash>] returns the models updated successfully
    def update(models)
      super(convert_models_to_hashes(models))
    rescue App::CustomErrors::ItemDoesNotExistError => e
      raise App::CustomErrors::ItemDoesNotExistError, 'Game Token does not exist and cannot be updated.'
    end

    # Finds all entities matching the token name of the models arguments
    #
    # @param models [Array<App::GameToken::Model>] the game token models being searched for
    # @return [Array<Hash>] returns any entities found
    def find_all_by_name(models)
      query_obj = query

      models.each { |model| query_obj.where('token_name', '=', model.token_name) }

      run(query_obj)
    end
  end
end
