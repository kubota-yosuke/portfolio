class MattersController < ApplicationController
  def index
    @q = Matter.ransack(params[:q])
    @matters = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(3)
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
    @q = current_user.like_matters.ransack(params[:q])
    @like_matters = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private
  def matter_params
    params.require(:matter).permit(:title, :place, :description, :start_time, :finish_time, :image)
  end
end
