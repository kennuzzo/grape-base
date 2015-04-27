module API::V1
  class Root < Grape::API

    require 'grape-swagger'
    require 'api/utils/helpers'

    #with header : curl -H Accept:application/vnd.tltalk-v1+json https://api.myserver.com/users
    version 'v1' #, using: :header, vendor: 'tltalk' # header versioning

    helpers API::Utils::Helpers

    use ::WineBouncer::OAuth2


    mount API::V1::Example::RestApi

    desc 'swagger'
    add_swagger_documentation(
      api_version: 'v1', hide_format: true, base_path: 'api',hide_documentation_path: true, info: {
        title: "My Api",
        description: "",
        contact: "",
        license: "",
        license_url: "",
        terms_of_service_url: ""
    })

  end
end
