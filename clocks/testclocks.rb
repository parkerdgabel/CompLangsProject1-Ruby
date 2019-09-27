require './clock.rb'
require './alarmclock.rb'

class TestClocks
  def test_hour_set
    clock = Clock.new -1, 0
    alarm = AlarmClock.new -1, 0
    puts clock.get_hour
    puts alarm.get_alarmhour
  
  end

  def test_minute_set
    clock = Clock.new 0, -1
    alarm = AlarmClock.new 0, -1
    if clock.get_minute != 0
      puts 'Wrong hour set'
    end
    if alarm.get_alarm_minute != 0
      puts 'Wrong hour set'
    end
    clock.set_time 26, 0
    alarm.set_alarm 26, 0
    if clock.get_minute != 23
      puts 'Wrong hour set'
    end
    if alarm.get_alarm_minute != 23
      puts 'Wrong hour set'
    end
  end
end

test = TestClocks.new
test.test_hour_set
test.test_minute_set
