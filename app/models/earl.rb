class Earl < ApplicationRecord
	validates :full_url, presence: true, format: { with: URI.regexp }
	validates :full_url, :short_url, uniqueness: true

	after_create :generate_short_url

	private

		def generate_short_url
			#encode base 10 id as base 62 string as seen here https://gist.github.com/zumbojo/1073996
			i = id
			return Constants::ALPHABET[0] if i == 0
			s = ''
			base = Constants::ALPHABET.length
			while i > 0
				s << Constants::ALPHABET[i.modulo(base)]
				i /= base
			end
			self.update_attributes(short_url: s.reverse)
		end
end
