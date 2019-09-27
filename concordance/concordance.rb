# frozen_string_literal: true

#
# Concordance implements a concordance map for a given file
#
class Concordance
  #
  # A tuple for the concordance lin number and word number
  #
  class ConcordanceTuple
    #
    # A constructor for the tuple
    #
    # @param [Integer] line_number The line number that the word is on
    # @param [<Type>] word_number The word number for the word
    #
    def initialize(line_number, word_number)
      @line_number = line_number
      @word_number = word_number
    end

    #
    # To string for the Tuple
    #
    # @return [String] The stringified tuple
    #
    def to_s
      '(' + @line_number.to_s + ',' + @word_number.to_s + ')'
    end
  end

  #
  # Constructor for the Concordance
  #
  def initialize
    @hash = {}
  end

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
  # Produces the concordance map
  #
  # @param [String] infile_name The name of the file to read
  #
  def concordance(infile_name)
    @hash.clear
    line_number = 1
    File.readlines(infile_name).each do |line|
      words = wordify line
      word_number = 1
      words.each do |word|
        @hash[word] = [] if @hash[word].nil?
        @hash[word] << ConcordanceTuple.new(line_number, word_number)
        word_number += 1
      end
      line_number += 1
    end
  end

  #
  # Formats the tuples given properly
  #
  # @param [Array] vals The tuples to format
  #
  # @return [String] The formated tuples
  #
  def format_tuple_string(vals)
    str = ""
    vals.each { |tuple| str += tuple.to_s + ' ' }
    str.rstrip
  end

  #
  # Finds the length of the longest word in the map
  #
  # @return [Integer] The length of the longest key
  #
  def length_of_longest_key
    keys = @hash.keys
    unless keys.empty?
      max_word = keys.max { |a, b| a.length <=> b.length }
      return max_word.length
    end
  end

  #
  # Formats the keys properly
  #
  # @param [String] key The key to format
  # @param [Integer] longest_length The length of the longest key in the map
  #
  # @return [String] The formatted key
  #
  def format_key_string(key, longest_length)
    buffer = longest_length - key.length
    whitespace = ' ' * buffer
    whitespace + key
  end

  #
  # Formats a key value pair as per the spec
  #
  # @param [String] key The key to format
  # @param [Array] vals The tuples to foramt
  # @param [Integer] longest_length The length of the longest key
  #
  # @return [String] The formatted key-val pair
  #
  def format_key_val_string(key, vals, longest_length)
    format_key_string(key, longest_length) + ' ' + format_tuple_string(vals)
  end

  #
  # To string for the concordance map as per the spec
  #
  # @return [String] The formatted map
  #
  def to_s
    str = ''
    longest_key = length_of_longest_key
    unless @hash.empty?
      @hash.keys.sort.each do |key|
        str += format_key_val_string(key, @hash[key], longest_key) + "\n"
      end
    end
    str
  end
end

# Main routine for the program
if ARGV.length != 1
  puts 'Concordance needs exactly one argument'
  exit 1
end

unless File.exist?(ARGV[0])
  puts 'File given does not exists'
  exit 1
end

con = Concordance.new
con.concordance ARGV[0]
puts con
