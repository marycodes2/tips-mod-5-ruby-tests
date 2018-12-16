require 'active_support'
require 'active_support/core_ext'

class RecurringMoment
  def initialize(start:, interval:, period:)
    @start = start
    @interval = interval
    @period = period
  end

  def match(date)
    current = @start
    count = 0

    if @period == 'monthly'
      while @start.advance(months: count) < date
        count = (count + 1)
      end
    end

    if @period == "weekly" || @period == "daily"
      while current < date

        if @period == 'weekly'
          current = current.advance(weeks: @interval)
        elsif @period == 'daily'
          current = current.advance(days: @interval)
        end
      end
    end

      if @period == 'monthly' && (count % @interval == 0)
        current = @start.advance(months: count)
      end

    return current == date

  end

end
