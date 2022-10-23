# frozen_string_literal: true

i1 = Institution.create(
  name: 'Mars University',
  url_slug: 'mars_university',
  home_url: 'university.mars.planet',
  institution_type: Institution.institution_types[:university],
)

u1 = User.create(
  email: 'foo@foobar.edu',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Mars',
  last_name: 'Jiangster',
  user_type: User.user_types[:student],
  institution: i1
)

u2 = User.create(
  email: 'bar2@foobar.edu',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'John',
  last_name: 'Smith',
  user_type: User.user_types[:instructor],
  institution: i1
)

u3 = User.create(
  email: 'bar3@foobar.edu',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Al',
  last_name: 'Einstein',
  user_type: User.user_types[:student],
  institution: i1
)

c1 = Course.create(
  creator_id: 1,
  institution_id: 1,
  title: 'Rationality 101',
  term: Course.terms[:summer],
  year: 2022,
)

c2 = Course.create(
  creator_id: 2,
  institution_id: 1,
  title: 'Rationality 202',
  term: Course.terms[:winter],
  year: 2022,
)

c3 = Course.create(
  creator_id: u1.id,
  institution_id: 1,
  title: 'Rationality 303',
  term: Course.terms[:fall],
  year: 2022,
)

CourseMembership.create(
  course_id: c1.id,
  user_id: u3.id,
  role: CourseMembership.roles[:student]
)

CourseMembership.create(
  course_id: c2.id,
  user_id: u3.id,
  role: CourseMembership.roles[:student]
)

g1 = Group.create(
  title: 'The Cabal',
  institution_id: 1,
  creator_id: u1.id,
  public: 1
)

g2 = Group.create(
  title: 'The Murder',
  institution_id: 1,
  creator_id: u2.id,
  public: 1
)

GroupMembership.create(
  group_id: g2.id,
  user_id: u1.id,
  role: GroupMembership.roles[:member]
)

GroupMembership.create(
  group_id: g1.id,
  user_id: u3.id,
  role: GroupMembership.roles[:member]
)

# p1 = Post.create(
#   user_id: u1.id,s
#   post_text: 'Success is intentional',
#   context: g1
# )

# p2 = Post.create(
#   user_id: u1.id,
#   post_text: 'Failure is simply the result of lack of intention',
#   context: c2
# )

# p3 = Post.create(
#   user_id: u2.id,
#   post_text: 'Success is intentional and it is highly actional',
#   context: g1
# )

# p4 = Post.create(
#   user: u1,
#   post_text: 'Failure is simply the result of lack of intention',
#   context: c2
# )

# cm1 = Post.create(
#   user_id: u1.id,
#   post_text: 'Of course intention does not always lead to success',
#   context: p1
# )

# cm2 = Post.create(
#   user_id: u2.id,
#   post_text: 'But you have to have it to begin with',
#   context: p1
# )

# cm3 = Post.create(
#   user_id: u1.id,
#   post_text: 'Indeed intention is the first',
#   context: p2
# )
