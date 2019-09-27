#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Hailstones implements the hailstone sequence. Given a starting number it computes the sequence until it reaches one.
#
class Hailstones
  #
  # Constructor for the sequence
  #
  # @param [Integer] start_number The starting number for the sequence
  #
  def initialize(start_number)
    @start_number = start_number
    @sequence = [start_number]
  end

  #
  # Computes the sequence until it reaches one and adds each val into the sequence array
  #
  def compute_sequence
    until @sequence.last == 1
      last = @sequence.last
      last.even? ? @sequence.append(last / 2) : @sequence.append(3 * last + 1)
    end
  end

  #
  # Prints the first phase of the output
  #
  def print_beginning_phrase
    puts format('The hailstone sequence starting with %i:', @start_number)
  end

  #
  # Prints the sequence apropriately
  #
  def print_sequence
    @sequence.each_slice(8, &method(:print_group))
  end

  #
  # Prints the largest value in the sequence
  #
  def print_largest_value
    puts format('There are %i values; the largest is %i.', @sequence.length, @sequence.max)
  end

  private

  #
  # Prints a slice of up to 8 numbers appropiatly
  #
  # @param [Array] group A slice of the sequence with at most 8 values
  #
  def print_group(group)
    group.each do |val|
      val_str = val.to_s
      buffer = (5 - val_str.length)
      buffer = 5 if buffer.negative?
      whitespace = ' ' * buffer
      print format(whitespace + val.to_s)
    end
    puts
  end
end

# Main sequence for the program
if ARGV.length != 1
  puts 'Hailstones must have at least one command line argument'
  exit 1
end
hs = Hailstones.new(ARGV[0].to_i)
hs.print_beginning_phrase
hs.compute_sequence
hs.print_sequence
puts
hs.print_largest_value
