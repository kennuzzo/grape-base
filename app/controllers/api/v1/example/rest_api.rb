module API
  module V1
    module Example

      class RestApi < Grape::API
        include Grape::Kaminari

        namespace :examples do
          desc 'This is a Get Example'
          oauth2 false
          paginate per_page: 1, max_per_page: 1, offset: 1

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

          desc 'This is a POST Example'
          oauth2 false
          params do
            requires :name, type: String, desc: 'The required name field', documentation: {example: 'example name'}
            optional :dob, type: Date, desc: 'Day of birth', documentation: {example: Date.today}
            optional :location, type: String, desc: 'the description about the location', documentation: {example: "Mestre, Italy"}
          end
          post '/' do
            received_data = {
              fullname: permitted_params[:name],
              dob: permitted_params[:dob],
              location: permitted_params[:location]
            }
            present received_data, with: API::Entities::DummyDataEntity
          end


        end
      end
    end
  end
end
