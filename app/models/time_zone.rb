class TimeZone < ApplicationRecord
  def present
    text = utc_offset >= 0 ? 'UTC+' : 'UTC'
    "(#{text}#{format('%.2f', utc_offset / 3600.0)}) #{name}"
  end
end
