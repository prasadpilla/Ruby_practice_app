#A Mix-in module for conversions

module NumberHelper

		def number_to_currency(number, options={})

			unit 			= options[:unit] 			|| '$'
			precision		= options[:precision]		|| '2'
			delimeter 		= options[:delimeter]		|| ','
			separator		= options[:separator]		|| '.'

			separator		= '' if precision==0
			integer, decimal = number.to_s.split('.')



			i = integer.length
			until i <=3
				integer = integer.insert(i, delimeter)
			end



			if precision==0
					precise_dcimal= ''
			else
					#Make sure decimal is not nil
				decimal ||= '0'
					#Make sure decimal is not too large
				decimal = decimal[0, precision-1]
					#Make sure the decimal is not too short
				precise_decimal = decimal.ljust(precision, "0")
			end

			return unit + integer + separator + precise_decimal
		end

end