class Journey

  attr_reader :journeys

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journeys = Array.new
    @entry_station = nil
    @fare = 0
  end

  def add_entry_station entry_station
    @fare += PENALTY_FARE if in_journey?
    #self.add_journey nil
    @entry_station = entry_station
  end

  def add_journey exit_station
    @journeys.push({entry: @entry_station, exit: exit_station})
    in_journey? ? @fare += MINIMUM_FARE : @fare += PENALTY_FARE
    @entry_station = nil
  end

  def fare
    @fare
    # Needs to return a penalty fare if there is not entry_station or no exit station
    #in_journey? ? MINIMUM_FARE : PENALTY_FARE
  end

  def fare_paid
    @fare = 0
  end

  def in_journey?
    !!@entry_station
  end

end
