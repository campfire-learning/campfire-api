# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Web', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'iOS', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'Android', redirect_uri: '', scopes: '')
end

stanford = Institution.create!(
  name: "Stanford",
  institution_type: "university",
  url_slug: "stanford",
  home_url: "stanford.edu"
)

berkeley = Institution.create!(
  name: "UC Berkeley",
  institution_type: "university",
  url_slug: "berkeley",
  home_url: "berkeley.edu"
)

tony = User.create!(
  email: 'tony@campfire.com',
  password: 'to_be_determined_at_runtime',
  password_confirmation: 'to_be_determined_at_runtime',
  first_name: 'Tony',
  last_name: 'Jiang',
  institution: stanford,
  user_type: User.user_types[:admin]
)

joe = User.create!(
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
marshmallow = User.create!(
  email: 'marshmallow@campfire.com',
  password: 'to_be_determined_at_runtime',
  password_confirmation: 'to_be_determined_at_runtime',
  first_name: 'Marshmallow',
  last_name: 'Fire',
  institution: stanford,
  user_type: User.user_types[:bot]
)

interest = Interest.create!(
  title: 'Campfire General Interest',
  institution: stanford,
  creator_id: marshmallow.id,
  public: 1
)

InterestMembership.create!(
  interest_id: interest.id,
  user_id: tony.id,
  role: InterestMembership.roles[:member]
)

InterestMembership.create!(
  interest_id: interest.id,
  user_id: joe.id,
  role: InterestMembership.roles[:member]
)

##############################################
# Standard Grading Scheme - one decimal places; used at Stanford & Berkeley
##############################################

gs1 = GradingScheme.create!(
  name: 'Standard GPA Grading Scheme',
  creator: marshmallow
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'A+',
  definition: 'Excellent',
  max_percent: 100,
  min_percent: 97,
  points: 4.0
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'A',
  definition: 'Excellent',
  max_percent: 96,
  min_percent: 93,
  points: 4.0
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'A-',
  definition: 'Excellent',
  max_percent: 92,
  min_percent: 90,
  points: 3.7
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'B+',
  definition: 'Good',
  max_percent: 89,
  min_percent: 87,
  points: 3.3
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'B',
  definition: 'Good',
  max_percent: 86,
  min_percent: 83,
  points: 3.0
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'B-',
  definition: 'Good',
  max_percent: 82,
  min_percent: 80,
  points: 2.7
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'C+',
  definition: 'Fair',
  max_percent: 79,
  min_percent: 77,
  points: 2.3
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'C',
  definition: 'Fair',
  max_percent: 76,
  min_percent: 73,
  points: 2.0
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'C-',
  definition: 'Fair',
  max_percent: 72,
  min_percent: 70,
  points: 1.7
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'D+',
  definition: 'Passed',
  max_percent: 69,
  min_percent: 67,
  points: 1.3
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'D',
  definition: 'Passed',
  max_percent: 66,
  min_percent: 63,
  points: 1.0
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'D-',
  definition: 'Passed',
  max_percent: 62,
  min_percent: 60,
  points: 0.7
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'F',
  definition: 'Failed',
  max_percent: 59,
  min_percent: 0,
  points: 0
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'S',
  definition: 'Satisfactory',
  max_percent: 100,
  min_percent: 60,
  points: 0
)

GradingLevel.create!(
  grading_scheme_id: gs1.id,
  level_letter: 'U',
  definition: 'Unsatisfactory',
  max_percent: 59,
  min_percent: 0,
  points: 0
)

################################################
# Standard Grading Scheme 2 - two decimal places; used at U of Texas Austin
################################################

gs2 = GradingScheme.create!(
  name: 'Standard GPA Grading Scheme 2',
  creator_id: marshmallow.id
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'A+',
  definition: 'Excellent',
  max_percent: 100,
  min_percent: 97,
  points: 4.0
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'A',
  definition: 'Excellent',
  max_percent: 96,
  min_percent: 93,
  points: 4.0
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'A-',
  definition: 'Excellent',
  max_percent: 92,
  min_percent: 90,
  points: 3.67
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'B+',
  definition: 'Good',
  max_percent: 89,
  min_percent: 87,
  points: 3.33
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'B',
  definition: 'Good',
  max_percent: 86,
  min_percent: 83,
  points: 3.0
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'B-',
  definition: 'Good',
  max_percent: 82,
  min_percent: 80,
  points: 2.67
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'C+',
  definition: 'Fair',
  max_percent: 79,
  min_percent: 77,
  points: 2.33
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'C',
  definition: 'Fair',
  max_percent: 76,
  min_percent: 73,
  points: 2.0
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'C-',
  definition: 'Fair',
  max_percent: 72,
  min_percent: 70,
  points: 1.67
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'D+',
  definition: 'Passed',
  max_percent: 69,
  min_percent: 67,
  points: 1.33
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'D',
  definition: 'Passed',
  max_percent: 66,
  min_percent: 63,
  points: 1.0
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'D-',
  definition: 'Passed',
  max_percent: 62,
  min_percent: 60,
  points: 0.67
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'F',
  definition: 'Failed',
  max_percent: 59,
  min_percent: 0,
  points: 0
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'S',
  definition: 'Satisfactory',
  max_percent: 100,
  min_percent: 60,
  points: 0
)

GradingLevel.create!(
  grading_scheme_id: gs2.id,
  level_letter: 'U',
  definition: 'Unsatisfactory',
  max_percent: 59,
  min_percent: 0,
  points: 0
)

###########################################
# Simplified Grading Scheme - no plus/minus; used at Texas A&M
###########################################

sgs = GradingScheme.create!(
  name: 'Simplified GPA Grading Scheme',
  creator_id: marshmallow.id
)

GradingLevel.create!(
  grading_scheme_id: sgs.id,
  level_letter: 'A',
  definition: 'Excellent',
  max_percent: 100,
  min_percent: 90,
  points: 4.0
)

GradingLevel.create!(
  grading_scheme_id: sgs.id,
  level_letter: 'B',
  definition: 'Good',
  max_percent: 89,
  min_percent: 80,
  points: 3
)

GradingLevel.create!(
  grading_scheme_id: sgs.id,
  level_letter: 'C',
  definition: 'Fair',
  max_percent: 79,
  min_percent: 70,
  points: 2
)

GradingLevel.create!(
  grading_scheme_id: sgs.id,
  level_letter: 'D',
  definition: 'Passed',
  max_percent: 69,
  min_percent: 60,
  points: 1
)

GradingLevel.create!(
  grading_scheme_id: sgs.id,
  level_letter: 'F',
  definition: 'Failed',
  max_percent: 59,
  min_percent: 0,
  points: 0
)

GradingLevel.create!(
  grading_scheme_id: sgs.id,
  level_letter: 'S',
  definition: 'Satisfactory',
  max_percent: 100,
  min_percent: 60,
  points: 0
)

GradingLevel.create!(
  grading_scheme_id: sgs.id,
  level_letter: 'U',
  definition: 'Unsatisfactory',
  max_percent: 59,
  min_percent: 0,
  points: 0
)
