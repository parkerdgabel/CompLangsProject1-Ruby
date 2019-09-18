# frozen_string_literal: true
#! /usr/bin/env ruby

def wordify(infile)
  input = File.open(infile).read
  words = input.match(/(\d|[a-zA-Z])+(\d|[a-zA-Z]|-)*/)
  words
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
  words = wordify(ARGV[0])
  wordsort words
  outfile_name = ARGV[0].split('.')[0]
  File.open(outfile_name + '-sorted.txt', 'w') { |file| file.puts words }
end

main
