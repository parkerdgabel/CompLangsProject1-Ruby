# frozen_string_literal: true

class Concordance
  class ConcordanceTuple
    def initialize(line_number, word_number)
      @line_number = line_number
      @word_number = word_number
    end

    def to_s
      '(' + @line_number + ',' + @word_number + ')'
    end
  end

  def initialize
    @hash = Hash.new([])
  end

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

  def concordance(infile_name)
    line_number = 1
    File.readlines(infile_name).each do |line|
      words = wordify line
      word_number = 1
      words.each do |word|
        @hash[word] << ConcordanceTuple.new(line_number, word_number)
        word_number += 1
      end
      line_number += 1
    end
  end

  def format_tuple_string(vals)
    str = ""
    vals.each { |tuple| str += tuple.to_s }
    str.rstrip
  end

  def length_of_longest_key
    keys = @hash.keys
    max_word = keys.max { |a, b| a.length <=> b.length }
    max_word.length
  end

  def format_key_string(key, longest_length)
    buffer = key.length - longest_length
    whitespace = buffer * ' '
    whitespace + key
  end

  def format_key_val_string(key, vals, longest_length)
    format_key_string(key, longest_length) + ' ' + format_tuple_string(vals)
  end

  def to_s
    str = ''
    longest_key - length_of_longest_key
    @hash.each { |key, val| str += format_key_val_string key, val, longest_key + '\n'}
    str
  end
end
