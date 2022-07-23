# frozen_string_literal: true

# Seed the db with enough data that development can proceed smoothly
if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Web client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'iOS client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'Android client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'React client', redirect_uri: '', scopes: '')
end

User.first_or_create(
  email: 'foo@bar.com',
  password: 'password',
  password_confirmation: 'password',
  user_type: User.user_types[:student]
)

User.create!(
  email: 'bar@bar.com',
  password: 'password',
  password_confirmation: 'password',
  user_type: User.user_types[:instructor]
)

Course.first_or_create(
  creator_id: 1,
  owner_id: 1,
  title: 'Rationality 101',
  description: 'How to be reasonable'
)

Course.create!(
  creator_id: 1,
  owner_id: 1,
  title: 'Rationality 202',
  description: 'How to be reasonable and profitable'
)

Course.create!(
  creator_id: 1,
  owner_id: 1,
  title: 'Rationality 303',
  description: 'How to be reasonable, lovable, and profitable'
)

Klass.first_or_create(
  course_id: 1,
  creator_id: 1,
  owner_id: 1,
  start_date: '2022-08-19'
)

Klass.create!(
  course_id: 1,
  creator_id: 1,
  owner_id: 1,
  start_date: '2030-08-19'
)

KlassMembership.first_or_create(
  klass_id: 1,
  user_id: 1,
  role: 1
)

KlassMembership.create!(
  klass_id: 1,
  user_id: 2,
  role: 3
)

Group.first_or_create(
  name: 'The Cabal',
  creator_id: 1,
  owner_id: 1,
  description: 'People who sit around campfire',
  public: 1
)

Group.create(
  name: 'The Murder',
  creator_id: 1,
  owner_id: 1,
  description: 'A group of crows is called a murder',
  public: 1
)

GroupMembership.first_or_create(
  group_id: 1,
  user_id: 1
)

GroupMembership.create!(
  group_id: 1,
  user_id: 2
)

Post.first_or_create(
  creator_id: 1,
  post_text: 'Success is intentional',
  context_type: 1,
  context_id: 1,
  pinned: 1
)

Post.create!(
  creator_id: 1,
  post_text: 'Failure is simply the lack of intention',
  context_type: 2,
  context_id: 1
)
