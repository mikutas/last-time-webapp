require 'test_helper'

class AuthorizationTest < ActiveSupport::TestCase
  def setup
    @auth = OmniAuth.config.mock_auth[:google_oauth2]
  end

  test 'create_with_auth! should success with valid parameter' do
    assert Authorization.create_with_auth!(@auth)
  end

  test 'create_with_auth! should fail with invalid parameter' do
    assert_not Authorization.create_with_auth!(nil)
  end

  test 'find_by_auth should success with valid parameter' do
    Authorization.create_with_auth!(@auth).save
    assert Authorization.find_by_auth(@auth)
  end

  test 'find_by_auth should fail with invalid parameter' do
    assert_not Authorization.find_by_auth(nil)
  end

  test 'provider should be present' do
    invalid_provider = OmniAuth::AuthHash.new(
      provider: nil,
      uid: SecureRandom.uuid,
      info: { email: 'testuser@example.com' }
    )
    assert_not Authorization.create_with_auth!(invalid_provider)
  end

  test 'uid should be present' do
    invalid_uid = OmniAuth::AuthHash.new(
      provider: 'test',
      uid: nil,
      info: { email: 'testuser@example.com' }
    )
    assert_not Authorization.create_with_auth!(invalid_uid)
  end

  test 'user_id should be present' do
    user_id_empty = Authorization.new(uid: 0, provider: 'test')
    assert_not user_id_empty.save
  end

  test 'uid should not be duplicated within the same provider' do
    Authorization.create_with_auth!(@auth)
    duplicated_uid = Authorization.new(uid: @auth[:uid], provider: 'google_oauth2')
    assert_not duplicated_uid.save
  end
end
