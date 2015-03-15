require 'test_helper'

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

  test 'original_url normalization' do
    @link.original_url = 'google.de'

    assert_equal true, @link.valid?
    assert_equal 'http://google.de', @link.original_url
  end

  test 'generates token' do
    @link.token = nil
    assert_equal nil, @link.token
    assert_equal true, @link.save
    assert_equal 7, @link.token.size
  end
end
