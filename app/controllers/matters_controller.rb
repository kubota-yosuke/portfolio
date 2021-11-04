class MattersController < ApplicationController
  def index
    @matters = Matter.all
  end

  def show
    @matter = Matter.find(params[:id])
    @comments = @matter.comments
    @comment = current_user.comments.new
    @apply = Apply.find_by(matter_id: @matter.id)
  end

  def new
    @matter = Matter.new
  end

  def create
    @matter = current_user.matters.new(matter_params)

    if @matter.save
      redirect_to @matter
      flash[:success] = "投稿しました"
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
      flash[:success] = "投稿を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @matter = current_user.matters.find(params[:id])
    @matter.destroy
    redirect_to matters_url
    flash[:success] = "投稿を削除しました"
  end

  def likes
    @like_matters = current_user.like_matters.includes(:user).order(created_at: :desc)
  end

  private
  def matter_params
    params.require(:matter).permit(:title, :place, :description, :start_time, :finish_time, :image)
  end
end
