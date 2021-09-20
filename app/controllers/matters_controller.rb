class MattersController < ApplicationController
  def index
    @matters = Matter.all
  end

  def show
    @matter = Matter.find(params[:id])
  end

  def new
    @matter = Matter.new
  end

  def create
    @matter = current_user.matters.new(matter_params)

    if @matter.save
      redirect_to @matter
    else
      render :new
    end
  end

  def edit
    @matter = current_user.matters.find(params[:id])
  end

  def update
    @matter = current_user.matters.find(params[:id])
    
    if @matter.update(matter_params)
      redirect_to @matter
    else
      render :edit
    end
  end

  def destroy
    @matter = current_user.matters.find(params[:id])
    @matter.destroy
    redirect_to matters_url
  end

  def likes
    @like_matters = current_user.like_matters.includes(:user).order(created_at: :desc)
  end 

  private
  def matter_params
    params.require(:matter).permit(:title, :place, :description)
  end
end
