class CommentsController < ApplicationController
    before_action :not_contract_user, only: %i[ create ]

    def create
        @comment = current_user.comments.new(comment_params)
        if @comment.save
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :matter_id)
    end

    def not_contract_user
        @matter = Matter.find(comment_params[:matter_id])
        unless @matter.user.id == current_user.id || @matter.users.include?(current_user)
            redirect_back fallback_location: root_path, notice: "権限がありません"
        end
    end
end
