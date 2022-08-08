class PrototypesController < ApplicationController

  before_action :move_to_edit, except: [:index, :show]

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
      render 'index'
    else
      render 'edit'
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
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

end
