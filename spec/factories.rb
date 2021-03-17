# frozen_string_literal: true

require 'spec_helper'

FactoryBot.define do
  # global factory traits start
  trait :game_token_ds_params do
    ds_identifier { :id }
    ds_kind { 'GameToken' }
  end

  trait :game_token_base_params do
    id { 'token_id' }
    token_name { "token's name" }
    token_key { 'token_key' }
    token_domains { ['localhost'] }
  end
  # global factory traits end

  # factories start

  factory :base_model, class: Model::Model do

  end

  factory :game_token_base_hash, traits: %i[game_token_base_params], class: Hash do
    initialize_with { new(**attributes) }
  end

  factory :game_token_full_hash, traits: %i[game_token_ds_params game_token_base_params], class: Hash do
    initialize_with { new(**attributes) }
  end

  factory :game_token, traits: %i[game_token_ds_params game_token_base_params], class: GameToken::Model do
    initialize_with { new(**attributes) }
  end

  factory :game_token_hash_array, class: Array[Hash] do
    (0..3).each { |i|
      game_token_base_hash
    }
  end

  # factories end
end