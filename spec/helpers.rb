# frozen_string_literal: true

module Helpers
  def create_game_token_model_array
    (0..3).map do |_i|
      build(:game_token)
    end
  end

  def create_game_token_full_hash_array
    (0..3).map do |_i|
      build(:game_token_full_hash)
    end
  end

  def create_game_token_base_hash_array
    (0..3).map do |_i|
      build(:game_token_base_hash)
    end
  end

  def create_entity_key_mock(game_token_full_hash)
    entity_key_mock = double
    allow(entity_key_mock).to receive(:kind).and_return(game_token_full_hash[:ds_kind])
    allow(entity_key_mock).to receive(:name).and_return(game_token_full_hash[game_token_full_hash[:ds_identifier]])
    entity_key_mock
  end

  def create_entity_properties_mock(game_token_base_hash)
    entity_properties_mock = double
    allow(entity_properties_mock).to receive(:to_h).and_return(game_token_base_hash)
    entity_properties_mock
  end

  def create_entity_mock(game_token_base_hash, game_token_full_hash)
    entity_mock = instance_double(Google::Cloud::Datastore::Entity)
    allow(entity_mock).to receive(:properties).and_return(create_entity_properties_mock(game_token_base_hash))
    allow(entity_mock).to receive(:key).and_return(create_entity_key_mock(game_token_full_hash))
    entity_mock
  end

  def create_data_source_parser_mock(entity_mock:, test_model_array:, game_token_base_hash:, test_hash_array:,
                                     kind_and_key_hash:, kind_and_key_hash_array:, google_key:, google_key_array:)
    data_source_parser = instance_double(Data::GoogleData::DataSourceParser)
    allow(data_source_parser).to receive(:entity_to_hash).with(entity_mock).and_return(game_token_base_hash)
    allow(data_source_parser).to receive(:entities_to_hashes).with(test_model_array).and_return(test_hash_array)
    allow(data_source_parser).to receive(:hash_to_entity).with(game_token_base_hash).and_return(entity_mock)
    allow(data_source_parser).to receive(:hashes_to_entities).with(test_hash_array).and_return(test_model_array)

    allow(data_source_parser).to receive(:convert_to_key).with(kind_and_key_hash).and_return(google_key)
    allow(data_source_parser).to receive(:convert_to_keys).with(kind_and_key_hash_array).and_return(google_key_array)
    data_source_parser
  end

  def mock_logger
    allow(App::AppLogger.instance).to receive(:unknown)
    allow(App::AppLogger.instance).to receive(:fatal)
    allow(App::AppLogger.instance).to receive(:error)
    allow(App::AppLogger.instance).to receive(:warn)
    allow(App::AppLogger.instance).to receive(:info)
    allow(App::AppLogger.instance).to receive(:debug)
  end
end
