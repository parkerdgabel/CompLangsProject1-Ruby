# frozen_string_literal: true
#! /usr/bin/env ruby

module Wordify
  def self.read_input
    $stdin.read
  end

  def self.wordify(words_from_input)
    invalid_characters = /[\\!@#\$%\^&\*\(\)\_\+=<>,\.;:'"{}]/
    valid_start = /(\d|[a-zA-Z])/
    words_from_input.split.select do |word|
      word.match?(valid_start) && !word.match?(invalid_characters)
    end
  end
end
