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
  end
end
