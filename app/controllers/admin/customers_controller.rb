class Admin::CustomersController < Admin::BaseController
    def index
      per_page = (params[:per_page] || 10).to_i
      page = (params[:page] || 1).to_i
      users = User.where.not(id: current_user.id).page(page).per(per_page) 
  
      render json: {
        customers: users.as_json(only: [:id, :name, :email]),
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_count: users.total_count,
      }
    end
  
    def create
      user = User.new(user_params.merge(role: 0))
  
      if user.save
        render json: user.as_json(only: [:id, :name, :email]), status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      user = User.find(params[:id])
  
      if user.destroy
        render json: {message: "Customer Deleted"}, status: :ok
      else
        render json: { errors: ["Failed to delete customer"] }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation) 
    end
  
  end
  