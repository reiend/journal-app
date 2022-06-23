# frozen_string_literal: true

module Users
  module Authentication
    # RegistrationsController Template
    class RegistrationsController < Devise::RegistrationsController
      def new
        @user = User.new
      end

      def create
        @user = User.new(signup_params)

        if @user.save
          sign_in @user
          redirect_to root_path, notice: 'successfully signup'
        else
          render :new, status: :unprocessable_entity
        end
      end

      private

      def signup_params
        params
          .require(:user)
          .permit(:email, :password, :password_confirmation)
      end
    end
  end
end
