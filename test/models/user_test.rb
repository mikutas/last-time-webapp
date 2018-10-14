require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'user@example.com')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert @user.invalid?
  end

  test 'email should not be too long' do
    # 256文字のemail
    @user.email = 'a' * 244 + '@example.com'
    assert @user.invalid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert duplicate_user.invalid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'associated events should be destroyed' do
    @user.save
    @user.events.create!(title: 'Lorem ipsum', occurred_at: Time.zone.now)
    @user.destroy
    assert_equal 0, @user.events.count
  end

  test 'associated authorizations should be destroyed' do
    @user.save
    @user.authorizations.create!(uid: 1, provider: 'Lorem ipsum')
    @user.destroy
    assert_equal 0, @user.authorizations.count
  end

  test 'create_with_auth! should create valid user' do
    auth = OmniAuth.config.mock_auth[:google_oauth2]
    assert User.create_with_auth!(auth)
  end

  test 'update_email should update email if necessary' do
    @user.save
    assert @user.update_email('update@example.com')
  end
end
