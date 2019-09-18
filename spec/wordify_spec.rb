# frozen_string_literal: true

require_relative '../wordify/wordify.rb'

RSpec.describe Wordify do
  context 'with empty string' do
    it 'returns an empty list given an empty string' do
      actual = Wordify.wordify ''
      expect(actual).to eq([])
    end
  end

  context 'with just plain words' do
    it 'returns a list of the plain words' do
      actual = Wordify.wordify 'How now brown cow'
      expect(actual).to eq(['How', 'now', 'brown', 'cow'])
    end
  end

  context 'with words starting in letters or digits' do
    it 'returns a list with those words' do
      actual = Wordify.wordify "1niner copy"
      expect(actual).to eq(['1niner', 'copy'])
    end
  end

  context 'with words with hyphens in the middle' do
    it 'returns words with hyphens' do
      actual = Wordify.wordify "word-with-hyphen"
      expect(actual).to eq(['word-with-hyphen'])
    end
  end

  context 'with word starting with underscore' do
    it 'returns an empty list given just a string starting with an underscore' do
      actual = Wordify.wordify "_word-with-hyphen"
      expect(actual).to eq([])
    end
  end
end
