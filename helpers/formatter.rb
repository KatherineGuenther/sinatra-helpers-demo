module HelpersDemo
  module Helpers
    module Formatters
      def pig_latin(english)
        words = english.split(' ')
        latin_words = words.map { |word| pig_latin_word(word) }
        latin_words.join(' ')
      end

      def username
        current_user.username if authenticated?
      end

      private

      ALPHABET = ('a'..'z').to_a
      VOWELS = %w(a e i o u)
      CONS = ALPHABET - VOWELS

      def pig_latin_word(english_word)
        english_word = english_word.downcase
        if VOWELS.include?(english_word[0])
          english_word + 'ay'
        elsif CONS.include?(english_word[0]) && CONS.include?(english_word[1])
          english_word[2..-1] + english_word[0..1] + 'ay'
        elsif english_word[0..1] == 'qu'
          english_word[2..-1] + 'quay'
        elsif english_word[0..2] == 'squ'
          english_word[3..-1] + 'squay'
        else
          english_word[1..-1] + english_word[0..0] + 'ay'
        end
      end
    end
  end
end

helpers HelpersDemo::Helpers::Formatters
