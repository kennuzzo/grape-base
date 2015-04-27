module API
  module V1
    module Example

      class RestApi < Grape::API
        include Grape::Kaminari
        paginate per_page: 1, max_per_page: 1, offset: 1

        namespace :example do
          desc 'This is a Get Example'
          oauth2 false
          get '/' do
            dummy_data = {
              id: 1,
              first: "Francesco",
              last:  "Guccini",
              dob:   Date.new(1940,06,14),
              location: 'Modena, Italy',
              internal_id: "this will be hidden via an entity",
              created_at: DateTime.now,
              updated_at: DateTime.now,
            }
            present dummy_data, with: API::Entities::DummyDataEntity
          end

          desc 'This is a Get Example'
          oauth2 false
          get '/' do
            dummy_data = {
              id: 1,
              first: "Francesco",
              last:  "Guccini",
              dob:   Date.new(1940,06,14),
              location: 'Modena, Italy',
              internal_id: "this will be hidden via an entity",
              created_at: DateTime.now,
              updated_at: DateTime.now,
            }
            present dummy_data, with: API::Entities::DummyDataEntity
          end


        end
      end
    end
  end
end
