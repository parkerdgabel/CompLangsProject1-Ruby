# frozen_string_literal: true

#
# Clock implementation using military time.
#
class Clock
  @@number_strs = {
    0 => [
      ' _ ',
      '| |',
      '|_|'
    ],
    1 => [
      '   ',
      '  |',
      '  |'
    ],
    2 => [
      ' _ ',
      ' _|',
      '|_ '
    ],
    3 => [
      ' _ ',
      ' _|',
      ' _|'
    ],
    4 => [
      '   ',
      '|_|',
      '  |'
    ],
    5 => [
      ' _ ',
      '|_ ',
      ' _|'
    ],
    6 => [
      ' _ ',
      '|_ ',
      '|_|'
    ],
    7 => [
      ' _ ',
      '  |',
      '  |'
    ],
    8 => [
      ' _ ',
      '|_|',
      '|_|'
    ],
    9 => [
      ' _ ',
      '|_|',
      '  |'
    ]
  }

  @@ampm_hash = {
    'a' => [
      ' _ ',
      '|_|',
      '| |'
    ],
    'p' => [
      ' _ ',
      '|_|',
      '|  '
    ]
  }

  def initialize(hour, minute)
    set_time hour, minute
  end

  def get_hour
    @hour
  end

  def get_minute
    @minutes
  end

  def set_time(hour, minute)
    hour = 0 if hour.negative?
    hour = 23 if hour > 23
    minute = 0 if minute.negative?
    minute = 59 if minute > 59
    time = Time.new(0, nil, nil, hour, minute, nil, nil)
    @hour = time.hour
    @minutes = time.min
  end

  def format_time
    hours = format_hour @hour
    minutes = format_minute @minutes
    ampm = @hour < 12 ? @@ampm_hash['a'] : @@ampm_hash['p']
    time = ''
    time += hours[0] + minutes[0] + ' ' + ampm[0] + "\n"
    time += hours[1] + minutes[1] + ' ' + ampm[1] + "\n"
    time += hours[2] + minutes[2] + ' ' + ampm[2] + "\n" + "\n"
    time
  end

  def format_hour(hour)
    first, second = hour.divmod(10)
    first_digit_arr = @@number_strs[first]
    second_digit_arr = @@number_strs[second]
    [
      first_digit_arr[0] + second_digit_arr[0] + ' ',
      first_digit_arr[1] + second_digit_arr[1] + '.',
      first_digit_arr[2] + second_digit_arr[2] + '.'
    ]
  end

  def format_minute minute
    first, second = minute.divmod(10)
    first_digit_arr = @@number_strs[first]
    second_digit_arr = @@number_strs[second]
    [
      first_digit_arr[0] + second_digit_arr[0],
      first_digit_arr[1] + second_digit_arr[1],
      first_digit_arr[2] + second_digit_arr[2]
    ]
  end
end
