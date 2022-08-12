class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.includes(:user)
    @name = @user.name
    @prototypes = @user.prototypes
  end

end
