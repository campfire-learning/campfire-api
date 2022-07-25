# frozen_string_literal: true

# Since "class" is a reserved word in Ruby, we can't use it - either in
# lower case or upper case - as a class or variable name. But since we are
# writing an education application, it'd be impossible/unwise to avoid the
# word "class", so we use "Klass".
# Klass - read "class" - refers to a specific offering of a course in a
# specific semester/quarter. Course is the more abstract concept. So if the
# course is "Psychology 101", the class can be "Psychology 101, Fall 2022"
# or "Psychology 101, Spring 2030", etc.
class Klass < ApplicationRecord
  belongs_to :course
  belongs_to :creator, class_name: :User
  belongs_to :owner, class_name: :User

  enum term: {spring: 1, summer: 2, fall: 3, winter: 4}
end
