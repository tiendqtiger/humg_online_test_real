class UserController < ApplicationController
	before_action :define_pagetitle, only: [:update_show]
  def update_show
  	@lst_user = User.where(:role => "user")
  end
end
