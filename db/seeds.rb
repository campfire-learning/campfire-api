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
