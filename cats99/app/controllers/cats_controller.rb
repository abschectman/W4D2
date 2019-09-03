class CatsController < ApplicationController

  def index 
    @cats = Cat.all
    render :index
  
  end

  def show
    @cat = Cat.find(params[:id])
    @data = {'Birthdate:' => @cat.birth_date, 'Gender: ' => @cat.sex, 'Color: ' => @cat.color, 'Description: ' => @cat.description}
    render :show
  
  end

  def new
  end

  def create
    new_cat = Cat.create!(cat_params)
    redirect_to cat_url(new_cat)
  end

  def update
    cat = Cat.find(params[:id])
    if persisted?
      cat.update(cat_params)
      redirect_to cat_url(cat)
     else
      render json: @cat.errors.full_messages, status: 422
     end
  end

  def edit
    
    @cat = Cat.find(params[:id])
    render :edit
  end

  private
    def cat_params
      params.require(:cat).permit(:name, :birth_date, :description, :color, :sex)
    end

    def persisted?
      Cat.find(params[:id]) ? true : false
    end
end