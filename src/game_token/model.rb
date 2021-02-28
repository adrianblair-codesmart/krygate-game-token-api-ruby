module GameToken
  class Model
    include App::Import['test_string']
    attr_accessor :id, :token_name, :token_key, :token_domains
  end
end
