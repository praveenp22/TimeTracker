Apartment.configure do |config|
	config.excluded_models  = ['Account']
	config.tenant_names = lambda{ Account.pluck(:subdomain) } #migrates all tenants on db:migrate
end	 