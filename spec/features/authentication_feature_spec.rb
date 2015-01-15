require 'rails_helper'

describe 'user authentication' do 
	let(:user) {build(:user)}
	let!(:account){create(:account_with_schema, owner: user)}

	it 'allows signin with valid credentials' do
	sign_user_in(user, subdomain: account.subdomain)
	expect(page).to have_content('Signed in successfully')
	end

	it 'does not allows signin with valid credentials' do
	sign_user_in(user, subdomain: account.subdomain, password: 'wrongpw')
	expect(page).to have_content('Invalid email or password')
	end

	it 'does not alow user to sign in unless on subdomain' do
		expect{visit new_user_session_path}.to raise_error ActionController::RoutingError 
	end

	it 'does allows user to sign out' do	
	sign_user_in(user, subdomain: account.subdomain)
	click_link 'Sign Out'
	expect(page).to have_content('Signed out successfully')
	end

	it 'does not allow user from one subdomain to sign in on another subdomain' do
		user2 = build(:user)
		account2 = create(:account_with_schema, owner: user2)

		sign_user_in(user2, subdomain: account2.subdomain)
		expect(page).to have_content('Signed in successfully')

		sign_user_in(user2, subdomain: account.subdomain)
		expect(page).to have_content('Invalid email or password')
	end

end

