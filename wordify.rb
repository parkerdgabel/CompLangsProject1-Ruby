#! /usr/bin/env ruby

module Wordify
  def self.read_input
    $stdin.read
  end

  def self.wordify
    input = read_input
    words = input.scan(/\w\w*\-*\w*/)
    puts words
  end
end

Wordify.wordify
