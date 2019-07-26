class UserController < ApplicationController
  def home
  end
  def homeAdmin
    @user = User.find(current_user.id)
  end

end
