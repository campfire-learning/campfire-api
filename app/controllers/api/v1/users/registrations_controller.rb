# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < ApiController
        # skip_before_action :doorkeeper_authorize!

        include DoorkeeperUserRenderable

        def create
          client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])
          unless client_app
            return render json: { error: I18n.t('doorkeeper.errors.messages.invalid_client') }, status: :unauthorized
          end

          create_params = user_params.except(:client_id)
          user = User.new(create_params)
          general_interest = Interest.select(:id).where(institution_id: user.institution_id).first
          if user.save
            InterestMembership.create(
              interest_id: general_interest.id,
              user_id: user.id,
              role: InterestMembership.roles[:member]
            )
            render json: render_user(user, client_app), status: :ok
          else
            render json: { errors: user.errors }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:registration).permit(
            :email, :password, :first_name, :last_name, :user_type, :institution_id, :client_id
          )
        end
      end
    end
  end
end
