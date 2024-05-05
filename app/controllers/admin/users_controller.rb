class Admin::UsersController < Admin::BaseController
    def index
        users = User.customer
        render json: users, status: :ok
    end
end
