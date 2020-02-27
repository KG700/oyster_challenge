class OysterCard
	attr_reader :balance  , :entry_station
	DEFAULT_BALANCE = 0
	MAXIMUM_BALANCE = 90
	MINIMUM_AMOUNT = 1
	def initialize(balance = DEFAULT_BALANCE)
		@balance = balance
		@entry_station = nil

	end

	def top_up(num)
		fail "You cant top up more than #{MAXIMUM_BALANCE} balance" if (@balance + num) > MAXIMUM_BALANCE
		@balance += num
	end

	def deduct(num)
		@balance -= num
	end

	def touch_in(entry_station)

		fail "You cannot travel as you have less than £#{MINIMUM_AMOUNT}" if @balance < MINIMUM_AMOUNT
		p entry_station
		@entry_station = entry_station

	end

	
	def touch_out
		deduct
		@entry_station = nil
		
	end

	def in_journey?
		!!entry_station
	end

	private 

	def deduct
		@balance -= MINIMUM_AMOUNT
	end
end
