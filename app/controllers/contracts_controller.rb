class ContractsController < ApplicationController
    def create
        @contract = Contract.create(matter_id: contract_params[:matter_id], user_id: contract_params[:user_id])
        Apply.find(contract_params[:apply_id]).destroy!
        redirect_to matter_applies_path(@contract.matter), notice:"「#{@contract.user.name}」と成約しました。"
    end

    def destroy
        @contract = Contract.find(params[:id])
        @contract.destroy!
        @matter = Matter.find(params[:matter_id])
        redirect_to matter_url(@matter), notice: "「#{@matter.title}」をキャンセルしました。"    
    end

    private

    def contract_params
        params.permit(:matter_id, :user_id, :apply_id)
    end
end
