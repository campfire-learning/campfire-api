# frozen_string_literal: true

# Seed the db with enough data that development can proceed smoothly
if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: 'Web client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'iOS client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'Android client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create(name: 'React client', redirect_uri: '', scopes: '')
end

u1 = User.first_or_create(
  email: 'foo@foobar.edu',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Mars',
  last_name: 'Jiangster',
  user_type: User.user_types[:teaching_assistant]
)

u2 = User.create(
  email: 'bar2@foobar.edu',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'John',
  last_name: 'Smith',
  user_type: User.user_types[:instructor]
)

u3 = User.create(
  email: 'bar3@foobar.edu',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Al',
  last_name: 'Einstein',
  user_type: User.user_types[:student]
)

c1 = Course.first_or_create(
  creator_id: 1,
  owner_id: 1,
  title: 'Rationality 101',
  description: 'How to be reasonable'
)

c2 = Course.create(
  creator_id: 1,
  owner_id: 1,
  title: 'Rationality 202',
  description: 'How to be reasonable and profitable'
)

c3 = Course.create(
  creator_id: u1.id,
  owner_id: u1.id,
  title: 'Rationality 303',
  description: 'How to be reasonable, lovable, and profitable'
)

k1 = Klass.first_or_create(
  course_id: c1.id,
  creator_id: u1.id,
  owner_id: u1.id,
  term: Klass.terms[:fall],
  year: 2022,
  start_date: '2022-08-19'
)

k2 = Klass.create(
  course_id: c2.id,
  creator_id: u2.id,
  owner_id: u2.id,
  term: Klass.terms[:winter],
  year: 2022,
  start_date: '2022-08-19'
)

k3 = Klass.create(
  course_id: c3.id,
  creator_id: u2.id,
  owner_id: u1.id,
  term: Klass.terms[:summer],
  year: 2022,
  start_date: '2022-08-19'
)

Klass.create(
  course_id: c3.id,
  creator_id: u2.id,
  owner_id: u2.id,
  term: Klass.terms[:spring],
  year: 2030,
  start_date: '2030-08-19'
)

KlassMembership.first_or_create(
  klass_id: k2.id,
  user_id: u1.id,
  role: 2
)

KlassMembership.create(
  klass_id: k3.id,
  user_id: u1.id,
  role: 2
)

KlassMembership.create(
  klass_id: k1.id,
  user_id: u1.id,
  role: 2
)

KlassMembership.create(
  klass_id: k1.id,
  user_id: u1.id,
  role: 3
)

KlassMembership.create(
  klass_id: k1.id,
  user_id: u3.id,
  role: 3
)

KlassMembership.create(
  klass_id: k2.id,
  user_id: u3.id,
  role: 3
)

g1 = Group.first_or_create(
  name: 'The Cabal',
  creator_id: u1.id,
  owner_id: u1.id,
  description: 'People who sit around campfire',
  public: 1
)

g2 = Group.create(
  name: 'The Murder',
  creator_id: u1.id,
  owner_id: u2.id,
  description: 'A group of crows is called a murder',
  public: 1
)

GroupMembership.create(
  group_id: g1.id,
  user_id: u1.id
)

GroupMembership.create(
  group_id: g2.id,
  user_id: u1.id
)

GroupMembership.create(
  group_id: g1.id,
  user_id: u3.id
)

Post.first_or_create(
  creator_id: u1.id,
  post_text: 'Success is intentional',
  context_type: 1,
  context_id: 1,
  pinned: 1
)

Post.create(
  creator_id: u1.id,
  post_text: 'Failure is simply the lack of intention',
  context_type: 2,
  context_id: 1
)
