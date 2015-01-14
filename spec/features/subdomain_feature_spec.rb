require 'rails_helper'

	describe 'subdomains' do |variable|
		let!(:account){create(:account_with_schema)}

		it 'redirects invalid accounts' do
			visit root_url(subdomain: 'random_subdomain')
			expect(page.current_url).to_not include('random-subdomdin_randomizer_random')
		end

		it 'allows valid accounts' do
			visit root_url(subdomain: account.subdomain)
			expect(page.current_url).to include(account.subdomain)
		end

		it 'forces user to login before accessing subdomain content' do
			visit root_url(subdomain: account.subdomain)
			expect(page.current_url).to have_content 'sign in or sing up before continuing'
		end	
	end