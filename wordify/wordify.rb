# frozen_string_literal: true
#! /usr/bin/env ruby

module Wordify
  def self.read_input
    $stdin.read
  end

  def self.is_digit(word)
    word[0].match?(/[0-9]/)
  end

  def self.is_alpha(word)
    word[0].match?(/[a-zA-Z]/)
  end

  def self.is_valid_start(word)
    is_alpha(word) || is_digit(word)
  end

  def self.wordify(words_from_input)
    words = words_from_input.split("\s")
    words.select do |word|
      is_valid_start word
    end
  end
end
