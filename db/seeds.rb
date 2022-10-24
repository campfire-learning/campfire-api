# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: 'Web', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'iOS', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'Android', redirect_uri: '', scopes: '')
end

stanford = Institution.create(
  name: "Stanford",
  institution_type: "university",
  url_slug: "stanford",
  home_url: "stanford.edu"
)

tony = User.create(
  email: 'tony@campfire.com',
  password: 'to_be_determined_at_runtime',
  password_confirmation: 'to_be_determined_at_runtime',
  first_name: 'Tony',
  last_name: 'Jiang',
  institution: stanford,
  user_type: User.user_types[:admin]
)

joe = User.create(
  email: 'joe@campfire.com',
  password: 'to_be_determined_at_runtime',
  password_confirmation: 'to_be_determined_at_runtime',
  first_name: 'Joe',
  last_name: 'Babbo',
  institution: stanford,
  user_type: User.user_types[:admin]
)

# Marsh Mallow is a chat bot who is always friendly, occassionally funny,
# sometimes, and inspirational from time to time
marshmallow = User.create(
  email: 'marshmallow@campfire.com',
  password: 'to_be_determined_at_runtime',
  password_confirmation: 'to_be_determined_at_runtime',
  first_name: 'Marshmallow',
  last_name: 'Fire',
  user_type: User.user_types[:bot]
)

interest = Interest.first_or_create(
  title: 'Campfire General Interest',
  creator_id: marshmallow.id,
  public: 1
)

InterestMembership.create(
  interest_id: interest.id,
  user_id: tony.id,
  role: InterestMembership.roles[:member]
)

InterestMembership.create(
  interest_id: interest.id,
  user_id: joe.id,
  role: InterestMembership.roles[:member]
)
