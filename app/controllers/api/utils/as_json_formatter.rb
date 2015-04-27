module Grape
  module Formatter
    module AsJson
      class << self
        def call(object, env)
          return object.as_json if object.respond_to?(:as_json)
          Oj.dump(object, mode: :object)
        end
      end
    end
  end
end