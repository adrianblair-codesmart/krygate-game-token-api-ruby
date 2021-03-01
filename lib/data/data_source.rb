# frozen_string_literal: true

# Namespace for data related modules and classes
# @author Adrian Blair
module Data
  # Base Class representing a data source
  #
  class DataSource
    def initialize; end

    def find(key_or_kind, id_or_name = nil); end

    def query(kind); end

    def insert(*entities); end

    def update(*entities); end

    def save(*entities); end

    def delete(*entities_or_keys); end
  end
end
