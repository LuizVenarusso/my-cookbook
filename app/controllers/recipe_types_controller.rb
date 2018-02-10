class RecipeTypesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :admin_only, except: :show
  before_action :set_recipe_type, only: [:show, :edit, :update]

  def show
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
    @recipe_types = RecipeType.all if current_user.admin?
  end

  def update
    if @recipe_type.update(recipe_type_params)
      redirect_to @recipe_type
    else
      @recipe_types = RecipeType.all
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end

  def admin_only
    redirect_to root_path, alert: 'Sem permissão' unless current_user.admin?
  end

  def set_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end
end
