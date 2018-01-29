class RecipeTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def show
    @recipe_type = RecipeType.find(params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      flash.now[:error] = 'Você deve informar o nome do tipo de receita'
      render :new
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end

  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Você não possui permissão para criar uma cozinha"
    end
  end

end