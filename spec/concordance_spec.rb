require_relative '../concordance/concordance.rb'

RSpec.describe Concordance do
    it 'does the right thing' do
        concord = Concordance.new
        concord.concordance './spec/seuss.txt'
        puts concord
        concord.concordance './empty.txt'
        puts concord
    end
end