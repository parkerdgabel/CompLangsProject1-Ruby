require_relative '../clocks/clock.rb'

RSpec.describe Clock do
    it 'prints the right thing' do
        clock = Clock.new 0, 0
        clock.format_time
    end
end