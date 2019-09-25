# frozen_string_literal: true
#! /usr/bin/env ruby

def is_digit(char)
  char.match?(/[0-9]/)
end

def is_alpha(char)
  char.match?(/[a-zA-Z]/)
end

def is_valid_start(word)
  is_alpha(word[0]) || is_digit(word[0])
end

def is_valid_middle(char)
  is_alpha(char) || is_digit(char) || char == '-'
end

def wordify(words_from_input)
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

def binary_search(words, word, low = 0, high = words.length - 1)
  if low == high
    if words[low] > word
      return low
    else
      return low + 1
    end
  end

  if low > high
    return low
  end

  mid = (low + high) / 2
  if words[mid] < word
    return binary_search words, word, mid + 1, high
  elsif words[mid] > word
    return binary_search words, word, low, mid - 1
  else
    return mid
  end
end

def wordsort(words)
  
end

def main
  if ARGV.length != 1
    puts 'Wordsort takes a single, required argument containing the text to be sorted.'
    exit(1)
  end
  infile = File.open(ARGV[0])
  words_from_input = infile.read
  words = wordify(words_from_input)
  wordsort words
  outfile_name = ARGV[0].split('.')[0]
  File.open(outfile_name + '-sorted.txt', 'w') { |file| file.puts words }
end

