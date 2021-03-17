module Helpers
  def create_game_token_entity_array()
    (0..3).map do |i|
      build(:game_token)
    end
  end

  def create_game_token_hash_array()
    (0..3).map do |i|
      build(:game_token_full_hash)
    end
  end

  def create_entity_key_mock()
    entity_key_mock = double
    allow(entity_key_mock).to receive(:kind).and_return(game_token_full_hash[:ds_kind])
    allow(entity_key_mock).to receive(:id).and_return(game_token_full_hash[game_token_full_hash[:ds_identifier]])
    entity_key_mock
  end

  def create_entity_properties_mock()
    entity_properties_mock = double
    allow(entity_properties_mock).to receive(:to_h).and_return(game_token_base_hash)
    entity_properties_mock
  end

  def create_entity_mock()
    entity_mock = instance_double(Google::Cloud::Datastore::Entity)
    allow(entity_mock).to receive(:properties).and_return(create_entity_properties_mock)
    allow(entity_mock).to receive(:key).and_return(create_entity_key_mock)
    entity_mock
  end

end