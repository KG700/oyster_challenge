class Oystercard

	attr_reader :balance  , :entry_station, :journeys

	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	def initialize
		@balance = balance
		@entry_station = nil
		@journeys = []

	end

	def top_up(num)
		fail "You cant top up more than #{MAXIMUM_BALANCE} balance" if (@balance + num) > MAXIMUM_BALANCE
		@balance += num
	end

	def deduct(num)
		@balance -= num
	end

	def touch_in(entry_station)

		fail "You cannot travel as you have less than £#{MINIMUM_FARE}" if @balance < MINIMUM_FARE
		@entry_station = entry_station

	end


	def touch_out(exit_station)
		deduct
		@journeys.push({entry: entry_station, exit: exit_station})
		@entry_station = nil
	end

	def in_journey?
		!!entry_station
	end

	private

	def deduct
		@balance -= MINIMUM_FARE
	end
end
