# frozen_string_literal: true

u1 = User.create(
  email: 'foo@foobar.edu',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Mars',
  last_name: 'Jiangster',
  user_type: User.user_types[:assistant]
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

Institution.create(
  name: 'Mars University',
  url_slug: 'mars_university',
  home_url: 'university.mars.planet',
  institution_type: Institution.institution_types[:university],
  country: 'Mars'
)

c1 = Course.create(
  creator_id: 1,
  owner_id: 1,
  institution_id: 1,
  title: 'Rationality 101',
  description: 'How to be reasonable',
  term: Course.terms[:summer],
  year: 2022,
  start_date: '2022-08-19'
)

c2 = Course.create(
  creator_id: 1,
  owner_id: 1,
  institution_id: 1,
  title: 'Rationality 202',
  description: 'How to be reasonable and profitable',
  term: Course.terms[:winter],
  year: 2022,
  start_date: '2022-08-19'
)

c3 = Course.create(
  creator_id: u1.id,
  owner_id: u1.id,
  institution_id: 1,
  title: 'Rationality 303',
  description: 'How to be reasonable, lovable, and profitable',
  term: Course.terms[:fall],
  year: 2022,
  start_date: '2022-08-19'
)

CourseMembership.create(
  course_id: c2.id,
  user_id: u1.id,
  role: CourseMembership.roles[:admin]
)

CourseMembership.create(
  course_id: c3.id,
  user_id: u1.id,
  role: CourseMembership.roles[:member]
)

CourseMembership.create(
  course_id: c1.id,
  user_id: u1.id,
  role: CourseMembership.roles[:member]
)

CourseMembership.create(
  course_id: c1.id,
  user_id: u1.id,
  role: CourseMembership.roles[:member]
)

CourseMembership.create(
  course_id: c1.id,
  user_id: u3.id,
  role: CourseMembership.roles[:member]
)

CourseMembership.create(
  course_id: c2.id,
  user_id: u3.id,
  role: CourseMembership.roles[:member]
)

g1 = Group.create(
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

p1 = Post.create(
  user_id: u1.id,
  post_text: 'Success is intentional',
  context: g1
)

p2 = Post.create(
  user_id: u1.id,
  post_text: 'Failure is simply the result of lack of intention',
  context: c2
)

p3 = Post.create(
  user_id: u2.id,
  post_text: 'Success is intentional and it is highly actional',
  context: g1
)

p4 = Post.create(
  user: u1,
  post_text: 'Failure is simply the result of lack of intention',
  context: c2
)

cm1 = Post.create(
  user_id: u1.id,
  post_text: 'Of course intention does not always lead to success',
  context: p1
)

cm2 = Post.create(
  user_id: u2.id,
  post_text: 'But you have to have it to begin with',
  context: p1
)

cm3 = Post.create(
  user_id: u1.id,
  post_text: 'Indeed intention is the first',
  context: p2
)

Like.create(
  user_id: 1,
  likable_id: 1,
  likable_type: 'Post'
)

Like.create(
  user: u2,
  likable: cm2
)

Like.create(
  user: u2,
  likable: cm1
)
