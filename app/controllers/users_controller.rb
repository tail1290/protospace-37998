class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.includes(:user)
  end

end
