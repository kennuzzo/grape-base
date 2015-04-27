WineBouncer.configure do |config|
  config.auth_strategy = :protected

  config.define_resource_owner do
    User.where(id: doorkeeper_access_token.resource_owner_id).limit(1) if doorkeeper_access_token
  end
end