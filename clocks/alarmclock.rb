# frozen_string_literal: true

#
# AlarmClock implementation using military time.
#
class AlarmClock < Clock
  #
  # Constructor for the Alarmclock
  #
  # @param [Integer] hour The hour to set the clock to
  # @param [Integer] minute The minute to set the clock to
  #
  def initialize(hour, minute)
    super(hour, minute)
    set_alarm hour, minute
  end

  #
  # Getter for alarmhour
  #
  # @return [Integer] The current alarmhour set in the clock
  #
  def get_alarmhour
    @alarm_hour
  end

  #
  # Getter for alarmminutes
  #
  # @return [Integer] The current alarm minutes set in the clock
  #
  def get_alarm_minute
    @alarm_minutes
  end

  #
  # Sets the alarm to the given hour and minute
  #
  # @param [Integer] hour The hour to set to
  # @param [Minute] minute The minute to set to
  #
  def set_alarm(hour, minute)
    hour = 0 if hour.negative?
    hour = 23 if hour > 23
    minute = 0 if minute.negative?
    minute = 59 if minute > 59
    time = Time.new(0, nil, nil, hour, minute, nil, nil)
    @alarm_hour = time.hour
    @alarm_minutes = time.min
  end

  #
  # Formats the alarm time as per the spec
  #
  # @return [String] The formatted string
  #
  def format_alarm
    hours = format_hour @alarm_hour
    minutes = format_minute @alarm_minutes
    ampm = @alarm_hour < 12 ? @@ampm_hash['a'] : @@ampm_hash['p']
    time = ''
    time += hours[0] + minutes[0] + ' ' + ampm[0] + "\n"
    time += hours[1] + minutes[1] + ' ' + ampm[1] + "\n"
    time += hours[2] + minutes[2] + ' ' + ampm[2] + "\n" + "\n"
    time
  end
end
