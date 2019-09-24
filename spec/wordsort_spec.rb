# frozen_string_literal: true

require_relative '../wordsort/wordsort.rb'

RSpec.describe do
  context 'with empty list' do
    it 'returns an empty list given an empty list' do
      actual = []
      wordsort actual
      expect(actual).to eq([])
    end
  end
  context 'with sorted list' do
    it 'returns the same list' do
      actual = ['a', 'b', 'c', 'zee']
      wordsort actual
      expect(actual).to eq(['a', 'b', 'c', 'zee'])
    end
  end
  context 'with an unsorted list' do
    it 'returns a sorted list' do
      actual = ['zee', 'b', 'a', 'c']
      wordsort actual
      expect(actual).to eq(['a', 'b', 'c', 'zee'])
    end
  end
end
