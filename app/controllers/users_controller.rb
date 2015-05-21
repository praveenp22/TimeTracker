class UsersController < ApplicationController
	def index
		@users = User.all
		@invited_users = User.order('invitation_token DESC NULLS FIRST')
	end
end