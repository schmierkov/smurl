class Link < ActiveRecord::Base
  LETTERS = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten

  validates :token, presence: true
  validates_uniqueness_of :token

  validates :original_url, presence: true, allow_nil: false
  validate  :original_url_format_valid?
  validates_uniqueness_of :original_url

  before_validation :generate_token

  private

  def generate_token
    begin
      self.token = (0...7).map { LETTERS[rand(LETTERS.length)] }.join
    end while self.class.exists?(token: token)
  end

  def original_url_format_valid?
    errors.add(:original_url, "is invalid.") unless is_url?(original_url)
  end

  def is_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end
