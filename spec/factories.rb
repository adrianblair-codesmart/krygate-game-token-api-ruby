# frozen_string_literal: true

require 'spec_helper'
require 'google/cloud/datastore'

FactoryBot.define do
  # global factory traits start
  trait :game_token_ds_params do
    ds_identifier { :id }
    ds_kind { 'GameToken' }
  end

  trait :game_token_base_params do
    id { 'token_id' }
    token_name { "token's name" }
    # token_key { 'token_key' }
    token_domains { ['localhost'] }
  end
  # global factory traits end

  # factories start

  factory :base_model, class: Model::Model do
  end

  factory :game_token_base_hash, traits: %i[game_token_base_params], class: Hash do
    initialize_with { new.merge(**attributes) }
  end

  factory :game_token_full_hash, traits: %i[game_token_ds_params game_token_base_params], class: Hash do
    initialize_with { new.merge(**attributes) }
  end

  factory :game_token, traits: %i[game_token_ds_params game_token_base_params], class: GameToken::Model do
    initialize_with { new(**attributes) }
  end

  factory :google_ds_entity, class: Google::Cloud::Datastore::Entity do
  end

  factory(:kind_and_key_hash, class: Hash) do
    initialize_with do
      { kind: 'GameToken', id: 'abc123' }
    end
  end

  factory(:kind_and_key_hash_array, class: Array) do
    initialize_with do
      [
        { kind: 'GameToken', id: 'abc123' },
        { kind: 'GameToken', id: 'abc1234' },
        { kind: 'GameToken', id: 'abc1235' },
        { kind: 'GameToken', id: 'abc1236' }
      ]
    end
  end

  factory(:google_key, class: Google::Cloud::Datastore::Key) do
    initialize_with do
      { kind: 'GameToken', id_or_name: 'abc123' }
    end
  end

  factory(:google_key_array, class: Array) do
    initialize_with do
      [
          Google::Cloud::Datastore::Key.new("GameToken",  "abc123"),
          Google::Cloud::Datastore::Key.new("GameToken", "abc1234"),
          Google::Cloud::Datastore::Key.new("GameToken", "abc1235"),
          Google::Cloud::Datastore::Key.new("GameToken", "abc1236")
      ]
    end
  end

  # factories end
end
