class AppliesController < ApplicationController
  def index
    @applies = Apply.where(matter_id: params[:matter_id])
  end

  def create
    current_user.applies.create(matter_id: apply_params[:matter_id])
    redirect_to matter_path(apply_params[:matter_id])
    flash[:success] = "申請しました"
  end

  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy!
    @matter = Matter.find(params[:matter_id])
    redirect_to matter_path(@matter)
    flash[:success] = "申請を取り消しました"
  end

  private

  def apply_params
    params.permit(:matter_id)
  end
end
