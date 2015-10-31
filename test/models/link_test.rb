require 'test_helper'
require 'mocha/api'

class LinkTest < ActiveSupport::TestCase

  def setup
    @link = build(:link)
  end

  test 'valid factory' do
    assert_equal true, @link.valid?
  end

  test 'original_url blank' do
    @link.original_url = ''
    assert_equal false, @link.valid?
  end

  test 'original_url allow nil' do
    @link.original_url = nil

    assert_equal false, @link.valid?
  end

  test 'generates token' do
    @link.token = nil
    assert_equal nil, @link.token
    assert_equal true, @link.save
    assert_equal 7, @link.token.size
  end

  test 'unique original_url' do
    @link.save
    another_link = build(:link, token: 'foo')

    assert_raises(ActiveRecord::RecordNotUnique) {
      another_link.save!
    }
  end

  test 'unique token' do
    @link.save
    another_link = build(:link, original_url: 'http://example.com/bar')
    another_link.token = @link.token
    another_link.stubs(:generate_token).returns(true)

    assert_raises(ActiveRecord::RecordNotUnique) { another_link.save }
  end
end
