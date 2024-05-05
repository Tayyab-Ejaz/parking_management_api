class Admin::BaseController < ApplicationController
    before_action :authenticate_user!,  :authorize_admin

    private

    def authorize_admin
        puts current_user.id
        unless current_user.admin?
            render json: {
                    message: "You are not authorized to perform this action."
            }, status: 403
        end
    end
end