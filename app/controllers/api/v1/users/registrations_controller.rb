# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < ApiController
        skip_before_action :doorkeeper_authorize!

        include DoorkeeperUserRenderable

        def create
          client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])
          unless client_app
            return render json: { error: I18n.t('doorkeeper.errors.messages.invalid_client') }, status: :unauthorized
          end

          create_params = user_params.except(:client_id)
          user = User.new(create_params)

          if user.save
            GroupMembership.create(
              group_id: Group.campfire_general.id,
              user_id: user.id,
              role: GroupMembership.roles[:memeber]
            )
            render json: render_user(user, client_app), status: :ok
          else
            render json: { errors: user.errors }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:registration).permit(
            :email, :password, :first_name, :last_name, :user_type, :organization_id, :client_id
          )
        end
      end
    end
  end
end
