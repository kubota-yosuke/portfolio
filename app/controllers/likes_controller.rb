class LikesController < ApplicationController
  def create
    matter = Matter.find(params[:matter_id])
    current_user.like(matter)
    redirect_back fallback_location: root_path
  end

  def destroy
    matter = current_user.likes.find(params[:id]).matter
    current_user.unlike(matter)
    redirect_back fallback_location: root_path
  end
end
