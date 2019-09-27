# frozen_string_literal: true
#! /usr/bin/env ruby

#
# Wordify provides the necessary functions to produce the words as per the spec
#
module Wordify
  #
  # Reads input from stdin
  #
  # @return [String] The input
  #
  def self.read_input
    $stdin.read
  end

  #
  # Checks if a character is a digit
  #
  # @param [String] char the character to check
  #
  # @return [Boolean] true if the character is a digit false otherwise
  #
  def self.is_digit(char)
    char.match?(/[0-9]/)
  end

  #
  # Checks if a character is alphabetic
  #
  # @param [String] char the character to check
  #
  # @return [Boolean] true if the character is alphabetic false otherwise
  #
  def self.is_alpha(char)
    char.match?(/[a-zA-Z]/)
  end

  #
  # Checks if a word has a valid start as defined by the spec
  #
  # @param [String] word The word to check 
  #
  # @return [Boolean] true if the word has a valid start false otherwise
  #
  def self.is_valid_start(word)
    is_alpha(word[0]) || is_digit(word[0])
  end

  #
  # Checks if a word has a valid middle as defined by the spec
  #
  # @param [String] word The word to check
  #
  # @return [Boolean] true if the word has a valid middle false otherwise
  #
  def self.is_valid_middle(char)
    is_alpha(char) || is_digit(char) || char == '-'
  end

  #
  # Wordifys the input
  #
  # @param [String] words_from_input The words to wordify
  #
  # @return [Arrray] The wordified words 
  #
  def self.wordify(words_from_input)
    words = words_from_input.split(/[\s\(\)!?]/)
    words = words.select {|word| word != ''}
    final_words = []
    words.each do |word|
      next unless is_valid_start word

      temp_word = ''
      word.each_char do |char|
        if is_valid_middle char
          temp_word += char
        else
          final_words << temp_word
          temp_word = ''
        end
      end
      final_words << temp_word unless temp_word.empty?
    end
    final_words
  end
end

# Main routine for the program
words_from_input = Wordify.read_input
puts Wordify.wordify words_from_input