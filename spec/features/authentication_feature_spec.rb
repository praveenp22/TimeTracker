require 'rails_helper'

describe 'user authentication' do
	let(:user) {build(:user)}
	let!(:account) {create(:account, owner: user)}

	it 'allows signin with valid credentials' do
	sign_user_in(create(:user))
	expect(page).to have_content('Signed in successfully')
	end

	it 'does not allows signin with valid credentials' do
	sign_user_in(create(:user), password: 'wrongpw')
	expect(page).to have_content('Invalid email or password')
	end

	it 'does not allow user to sing in unless on subdomain' do
		expect {visit new_user_session_path}.to raise_error ActionController:RoutingError
	end	

	it 'does allows user to sign out' do	
	sign_user_in(user, subdomain: account.subdomain)
	click_link 'Sign Out'
	expect(page).to have_content('Signed out successfully')
	end

end

def sign_user_in(user, opts={})
	visit new_user_session_url(subdomain: opts[:subdomain])
	fill_in 'Email', with: user.email
	fill_in 'Password', with: (opts[:password] || user.password)
	click_button 'Log in'
end	