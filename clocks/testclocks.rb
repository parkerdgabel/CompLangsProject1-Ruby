# frozen_string_literal: true

require './clock.rb'
require './alarmclock.rb'

#
# Tester class for the clocks
#
class TestClocks
  #
  # Tests the hour sets
  #
  def test_hour_set
    clock = Clock.new -1, 0
    alarm = AlarmClock.new -1, 0
    puts clock.get_hour
    puts alarm.get_alarmhour
  end

  #
  # Test the minute sets
  #
  def test_minute_set
    clock = Clock.new 0, -1
    alarm = AlarmClock.new 0, -1
    puts 'Wrong hour set' if clock.get_minute != 0
    puts 'Wrong hour set' if alarm.get_alarm_minute != 0
    clock.set_time 26, 0
    alarm.set_alarm 26, 0
    puts 'Wrong hour set' if clock.get_minute != 23
    puts 'Wrong hour set' if alarm.get_alarm_minute != 23
  end
end

test = TestClocks.new
test.test_hour_set
test.test_minute_set
