require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "soft delete aka discard" do
    User.first_or_create(
      email: 'marsh.mallow@campfire.com',
      password: 'to_be_determined_at_runtime',
      password_confirmation: 'to_be_determined_at_runtime',
      first_name: 'Marsh',
      last_name: 'Mallow',
      user_type: User.user_types[:bot]
    )

    kept_user_ids = User.kept.map(&:id)
    user = User.first
    assert kept_user_ids.include? user.id

    user.discard
    kept_user_ids = User.kept.map(&:id)
    assert_not kept_user_ids.include? user.id
    assert user.discarded?

    user.undiscard
    kept_user_ids = User.kept.map(&:id)
    assert kept_user_ids.include? user.id
    assert user.kept?
  end
end
