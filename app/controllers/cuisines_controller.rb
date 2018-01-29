class CuisinesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, except: :show

  def show
    @cuisine = Cuisine.find(params[:id])
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

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
  
  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Você não possui permissão para criar uma cozinha"
    end
  end

end
