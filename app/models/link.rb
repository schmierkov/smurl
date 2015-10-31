class Link < ActiveRecord::Base
  LETTERS = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten

  validates :original_url,
    presence: true,
    allow_nil: false,
    length: { maximum: 2000 }

  before_create :generate_token

  def token_url
    "http://smurl.schmierkov.de/#{token}"
  end

  private

  def generate_token
    begin
      self.token = (0...7).map { LETTERS[rand(LETTERS.length)] }.join
    end while token_exists?
  end

  def token_exists?
    self.class.exists?(token: token) || 'listings' == token
  end
end
