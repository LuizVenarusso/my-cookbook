class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :favorite, :unfavorite,
    :destroy]
    before_action :set_cuisines, only: [:new]


    def show
    end

    def new
      @recipe = Recipe.new
      @recipe_types = RecipeType.all
    end

    def create
      @recipe = Recipe.new(recipe_params)
      @recipe.user = current_user
      if @recipe.save
        redirect_to @recipe
      else
        @cuisines = Cuisine.all
        @recipe_types = RecipeType.all
        flash.now[:error] = 'Você deve informar todos os dados da receita'
        render :new
      end
    end

    def edit
      if current_user == @recipe.user
        @cuisines = Cuisine.all
        @recipe_types = RecipeType.all
      else
        flash[:notice] = 'Você não possui permissão para editar esta receita'
        redirect_to root_path
      end
    end

    def update
      if @recipe.update(recipe_params)
        redirect_to @recipe
      else
        @cuisines = Cuisine.all
        @recipe_types = RecipeType.all
        flash.now[:error] = 'Você deve informar todos os dados da receita'
        render :edit
      end
    end

    def search
      @search = params[:search]
      @results = Recipe.where("title LIKE ? OR ingredients LIKE ?", "%#{@search}%" , "%#{@search}%")

      flash.now[:error] = 'Nenhuma receita encontrada' if @results.empty?
    end

    def favorite
      Favorite.create(user: current_user , recipe: @recipe)
      flash[:success] = "Receita favoritada com sucesso"
      redirect_to @recipe
    end

    def unfavorite
      fav = Favorite.find_by(user: current_user, recipe: @recipe)
      fav.destroy
      flash[:success] = 'Receita desfavoritada com sucesso'
      redirect_to @recipe
    end

    def destroy
      @recipe.destroy
      flash[:success] = 'Receita removida com sucesso'
      redirect_to root_path
    end

    def share
      @recipe = Recipe.find(params[:id])
      email = params[:email]
      msg = params[:message]

      RecipesMailer.share(email, msg,
        @recipe.id).deliver_now

      flash[:notice] = "Receita enviada para #{email}"
      redirect_to @recipe
    end

    private

    def recipe_params
      params.require(:recipe).permit(:title,:recipe_type_id,
        :cuisine_id, :difficulty,
        :cook_time, :ingredients, :method, :image)
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_cuisines
      @cuisines = Cuisine.all
    end
    
  end
