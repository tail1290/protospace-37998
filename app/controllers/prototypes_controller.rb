class PrototypesController < ApplicationController

  before_action :move_to_edit, only: [:edit, :update]
  before_action :move_to_new, only: :new

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    Prototype.create(prototype_params)
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      render 'index'
    else
      render 'new'
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end
  
  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to action: :show
    else
      redirect_to action: :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    render 'index'
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_edit
    @prototype = Prototype.find(params[:id])
    @user = @prototype.user
    unless @user == current_user
      redirect_to 'http://localhost:3000/users/sign_in'
    end
  end

  def move_to_new
    unless user_signed_in?
      redirect_to 'http://localhost:3000/users/sign_in'
    end
  end


end
