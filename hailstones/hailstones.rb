#!/usr/bin/env ruby
# frozen_string_literal: true

class Hailstones
  def initialize(start_number)
    @start_number = start_number
    @sequence = [start_number]
  end

  def compute_sequence
    until @sequence.last == 1
      last = @sequence.last
      last.even? ? @sequence.append(last / 2) : @sequence.append(3 * last + 1)
    end
  end

  def print_beginning_phrase
    puts format('The hailstone sequence starting with %i:', @start_number)
  end

  def print_sequence
    @sequence.each_slice(8, &method(:print_group))
  end

  def print_largest_value
    puts format('There are %i values; the largest is %i.', @sequence.length, @sequence.max)
  end

  private

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

hs = Hailstones.new(ARGV[0].to_i)
hs.print_beginning_phrase
hs.compute_sequence
hs.print_sequence
puts
hs.print_largest_value