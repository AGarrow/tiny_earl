# an Earl represents a user submitted URL
class Earl < ApplicationRecord
  validates :full_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :full_url, :short_url, uniqueness: true

  after_create :generate_short_url

  scope :top_views, -> { order(view_count: :desc) }
  # override to_param in order to set primary lookup key as short_url instead of id
  def to_param
    short_url
  end

  private

    # generate short url by encoding id as base62 string and update field
    def generate_short_url
      # encode base 10 id as base 62 string as seen here https://gist.github.com/zumbojo/1073996
      i = id
      return Constants::ALPHABET[0] if i.zero?
      s = ''
      base = Constants::ALPHABET.length
      while i > 0
        s << Constants::ALPHABET[i.modulo(base)]
        i /= base
      end
      update_attributes(short_url: s.reverse)
    end
end
