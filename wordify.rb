#! /usr/bin/env ruby

module Wordify
  def self.read_input
    $stdin.read
  end

  def self.wordify
    input = read_input
    words = input.scan(/\b\w*\S*\b/)
    words.reject { |elem| elem == '' }
    puts words
  end
end

Wordify.wordify
