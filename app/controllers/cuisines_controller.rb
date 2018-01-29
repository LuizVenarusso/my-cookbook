class CuisinesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, except: :show
  before_action :set_cuisine, only: [:show, :edit, :update]

  def show
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      flash.now[:error] = 'Você deve informar o nome da cozinha'
      render :new
    end
  end

  def edit
    if current_user.admin?
     @cuisines = Cuisine.all
   end
 end

 def update
    if @cuisine.update(cuisine_params)
      redirect_to @cuisine
    else
      @cuisines = Cuisine.all
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

private

def cuisine_params
  params.require(:cuisine).permit(:name)
end

def admin_only
  unless current_user.admin?
    redirect_to root_path, :alert => "Você não possui permissão para acessar essa cozinha"
  end
end

def set_cuisine
  @cuisine = Cuisine.find(params[:id])
end

end
