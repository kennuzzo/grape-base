Rails.application.routes.draw do
  
  use_doorkeeper
  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'

end
