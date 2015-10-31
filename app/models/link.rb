class Link < ActiveRecord::Base
  LETTERS = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten

  validates :original_url, presence: true, allow_nil: false

  before_create :generate_token

  private

  def generate_token
    begin
      self.token = (0...7).map { LETTERS[rand(LETTERS.length)] }.join
    end while self.class.exists?(token: token)
  end
end
