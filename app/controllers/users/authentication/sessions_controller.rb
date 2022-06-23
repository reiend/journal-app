# frozen_string_literal: true

module Users
  module Authentication
    # SesssionsController Template
    class SessionsController < Devise::SessionsController
      def new; end

      def create
        user = User.find_by(email: params[:email])

        if user.present? && user.valid_password?(params[:password])
          sign_in user
          redirect_to root_path, notice: 'successfully signin'
        else
          redirect_to user_signin_path, notice: 'invalid email or password'
        end
      end

      def destroy
        # clear current user
        reset_session
        redirect_to user_signin_path, notice: 'successfully signout'
      end

      private

      def signin_params
        params
          .require(:user)
          .permit(:email, :password)
      end
    end
  end
end
