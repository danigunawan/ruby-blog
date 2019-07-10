class UsersController < ApplicationController
    before_action :authorize_request, except: [:createUser, :getAllUsers]
    #before_action :set_user, only: [:getUserId, :editUser, :deleteUser]

    def showUser
        render :json =>{message: @current_user}
    end
    
    def createUser
        @user= User.new(user_params)
    if @user.save
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render :json=> { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                        username: @user.name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
    end

    def getAllUsers
        @users= User.all
        render :json =>{message:@users}
    end

    def editUser
      if  @current_user.update(user_params_edit) 
        render :json=>{message:"update successful"}
      else
        render :json=>{message: @current_user.errors}
      end
    end

    def editPassword
        
        if @current_user&.authenticate(params[:old_password])
            @current_user.update(user_edit_password)
                render :json=>{message:"password updated successfully"}
         else
                render :json=>{message:"authorization failed"}
        end
    end
    
    def deleteUser
        if @current_user.destroy
            render :json=>{message:"user deleted successfully"}, status: :ok
        else
            render :json=>{message:"error deleting user"}
        end
    end
    
    private
    def user_params
        params.permit(
           :name, :email, :password, :password_confirmation
          ) 
    end

    def user_params_edit
        params.permit(
            :name, :email
           ) 
    end
    def user_edit_password
        params.permit(:password)
    end
end
