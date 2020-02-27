require_relative 'journey'

class Oystercard

	attr_reader :balance

	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	def initialize
		@balance = 0
		@journeys = Journey.new
	end

	def top_up(num)
		fail "You cant top up more than #{MAXIMUM_BALANCE} balance" if (@balance + num) > MAXIMUM_BALANCE
		@balance += num
	end


	def touch_in(entry_station)

		fail "You cannot travel as you have less than £#{MINIMUM_FARE}" if @balance < MINIMUM_FARE
		@journeys.add_entry_station entry_station

	end


	def touch_out(exit_station)
		@journeys.add_journey exit_station
		deduct(@journeys.fare)
		@journeys.fare_paid
	end

	def display_journeys
		@journeys.journeys
	end

	private

	def deduct(num)
		@balance -= num
	end
end
