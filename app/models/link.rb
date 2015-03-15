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
    errors.add(:original_url, "is invalid.") unless normalize(original_url)
  end

  def normalize(url)
    uri = URI.parse(url)
    url = uri.normalize.to_s
    url = "http://#{url}" if uri.scheme.nil?
    self.original_url = url
  rescue URI::InvalidURIError
    false
  end
end
