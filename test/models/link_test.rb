require 'test_helper'

class LinkTest < ActiveSupport::TestCase

  def setup
    @link = build(:link)
  end

  test 'valid factory' do
    assert_equal true, @link.valid?
  end

  test 'original_url format' do
    @link.original_url = 'fooooo'

    assert_equal false, @link.valid?
  end

  test 'original_url allow nil' do
    @link.original_url = nil

    assert_equal false, @link.valid?
  end

  test 'generates token' do
    assert_equal 0, @link.token.length

    @link.save

    assert_equal 7, @link.token.length
  end
end
