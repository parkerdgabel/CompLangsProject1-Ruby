# frozen_string_literal: true
#! /usr/bin/env ruby

module Wordify
  def self.read_input
    $stdin.read
  end

  def self.is_digit(char)
    char.match?(/[0-9]/)
  end

  def self.is_alpha(char)
    char.match?(/[a-zA-Z]/)
  end

  def self.is_valid_start(word)
    is_alpha(word[0]) || is_digit(word[0])
  end

  def self.is_valid_middle(char)
    is_alpha(char) || is_digit(char) || char == '-'
  end

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
