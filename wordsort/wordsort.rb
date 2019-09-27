# frozen_string_literal: true

# ! /usr/bin/env ruby
#

# Checks if a character is a digit
#
# @param [String] char the character to check
#
# @return [Boolean] true if the character is a digit false otherwise
#
def is_digit(char)
  char.match?(/[0-9]/)
end

#
# Checks if a character is alphabetic
#
# @param [String] char the character to check
#
# @return [Boolean] true if the character is alphabetic false otherwise
#
def is_alpha(char)
  char.match?(/[a-zA-Z]/)
end

#
# Checks if a word has a valid start as defined by the spec
#
# @param [String] word The word to check
#
# @return [Boolean] true if the word has a valid start false otherwise
#
def is_valid_start(word)
  is_alpha(word[0]) || is_digit(word[0])
end

#
# Checks if a word has a valid middle as defined by the spec
#
# @param [String] word The word to check
#
# @return [Boolean] true if the word has a valid middle false otherwise
#
def is_valid_middle(char)
  is_alpha(char) || is_digit(char) || char == '-'
end

#
# Wordifys the input
#
# @param [String] words_from_input The words to wordify
#
# @return [Arrray] The wordified words
#
def wordify(words_from_input)
  words = words_from_input.split(/[\s\(\)!?]/)
  words = words.reject { |word| word == '' }
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

#
# A binary search algorithm
#
# @param [Array] words The words array to sort
# @param [String] word The word to search for
# @param [Integer] low The lowest index to search
# @param [Integer] high The highest index to search
#
# @return [Integer] The position that the word should have in the array
#
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

#
# Sorts an array of wordified words inplace using a binary insertion sort
#
# @param [Array] words The array of words to sort
#
def wordsort(words)
  words.each_index do |i|
    next if i.zero?

    j = i - 1
    word = words[i]
    pos = binary_search words, word, 0, j
    while j >= pos
      words[j + 1] = words[j]
      j -= 1
    end
    words[j + 1] = word
  end
end

#
# Main Routine for the program
#
def main
  if ARGV.length != 1
    puts 'Wordsort takes a single, required argument containing the text to be sorted.'
    exit 1
  end
  unless File.exist?(ARGV[0])
    puts 'File given does not exist'
    exit 1
  end
  infile = File.open(ARGV[0])

  words_from_input = infile.read
  words = wordify(words_from_input)
  wordsort words
  outfile_name = ARGV[0].split('.')[0]
  File.open(outfile_name + '-sorted.txt', 'w') { |file| file.puts words }
end

main
