# frozen_string_literal: true

module DoorkeeperUserRenderable
  extend ActiveSupport::Concern
  def generate_refresh_token
    loop do
      # generate a random token string and return it
      # unless there is already another token with the same string
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end

  def render_user(user, client_app, token_type = 'Bearer')
    access_token = Doorkeeper::AccessToken.create(
      resource_owner_id: user.id,
      application_id: client_app.id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in,
      scopes: ''
    )

    {
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      user_type: user.user_type,
      institution_slug: Institution.find(user.institution_id).url_slug,
      access_token: access_token.token,
      token_type:,
      expires_in: access_token.expires_in,
      refresh_token: access_token.refresh_token,
      created_at: access_token.created_at.to_time.to_i
    }
  end
end
