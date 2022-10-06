# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: 'Web client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'iOS client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'Android client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'React client', redirect_uri: '', scopes: '')
end

ActiveSupport::TimeZone.all.each do |tz|
  TimeZone.create(
    name: tz.name,
    tz_identifier: tz.tzinfo.name,
    utc_offset: tz.utc_offset
  )
end

# The OG
u1 = User.first_or_create(
  email: 'yujiang99@gmail.com',
  password: 'to_be_determined_at_runtime',
  password_confirmation: 'to_be_determined_at_runtime',
  first_name: 'Mars',
  last_name: 'Jiangster',
  time_zone_id: 6,
  user_type: User.user_types[:admin]
)

# Marsh Mallow is a chat bot who is always friendly, occassionally funny,
# sometimes, and inspirational from time to time
User.create(
  email: 'yujiang99@gmail.com',
  password: 'to_be_determined_at_runtime',
  password_confirmation: 'to_be_determined_at_runtime',
  first_name: 'Marsh',
  last_name: 'Mallow',
  time_zone_id: 6,
  user_type: User.user_types[:bot]
)

Channel.first_or_create(
  name: 'Campfire General Channel',
  creator_id: u1.id,
  owner_id: u1.id,
  description: 'The general channel that includes all users',
  public: 1
)
