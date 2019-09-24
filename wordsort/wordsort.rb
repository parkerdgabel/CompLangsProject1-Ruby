# frozen_string_literal: true
#! /usr/bin/env ruby

def wordify(words_from_input)
  invalid_characters = /[\\!@#\$%\^&\*\(\)\_\+=<>,\.;:'"{}]/
    valid_start = /(\d|[a-zA-Z])/
    words_from_input.split.select do |word|
      word.match?(valid_start) && !word.match?(invalid_characters)
    end
end

def binary_search(words, word, low = 0, high = words.length - 1)
  if low == high
    if words[low] > word
      return low
    else
      return low + 1
    end
  end

  return low if low > high

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
  if words.empty?
    return []
  end
  i = 1
  until i >= words.count
    j = i - 1
    word = words[i]
    position = binary_search words, word
    while j >= position
      words[j + 1] = words[j]
      j -= 1
    end
    words[j + 1] = word
    i += 1
  end
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

