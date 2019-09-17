# frozen_string_literal: true

#
# Clock implementation using military time.
#
class Clock
  def initialize(hour, minute)
    set_time(hour, minute)
    rescue ArgumentError
      hour = 0 if hour.negative?
      hour = 23 if hour > 23
      minute = 0 if minute.negative?
      minute = 59 if minute > 59
      set_time(hour, minute)
  end

  def get_hour
    @hour
  end

  def get_minute
    @minute
  end

  def set_time(hour, minute)
    unless 0 <= hour && hour <= 24
      raise ArgumentError, 'Hour argument must be between 0 to 23'
    end
    unless 0 <= minute && minute <= 59
      raise ArgumentError, 'Minute argument must be between 0 and 59'
    end

    @hour = hour
    @minute = minute
  end
end
