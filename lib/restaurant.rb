require 'support/number_helper'

class Restaurant

	include NumberHelper
@@filepath = nil

attr_accessor :name, :cusine, :price

	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)

	end

	def self.file_exists?
		#to check if the file exists 
		if @@filepath && File.exists?(@@filepath)
			return true
		else 
			return false
		end
	end

	def self.file_usable?
		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true			
	end



	def self.create_file
		#Create the restaurant file
		File.open(@@filepath, 'w') unless file_exists?
		return file_usable?
	end


	def self.saved_restaurants
		#Read the restaurant file
		restaurants= []
		if file_usable?
			file = File.new(@@filepath, 'r')
			file.each_line do |line|
				restaurants << Restaurant.new.import_line(line.chomp)
			end
		file.close
	end
		#Return instances of restaurant
		return restaurants
	end

		def self.build_from_questions
			args = {}

			print "Restaurant name:"
			args[:name] = gets.chomp.strip
			print "Cusine type:"
			args[:cusine] = gets.chomp.strip
			print "Price:"
			args[:price] = gets.chomp.strip

			restaurant = Restaurant.new(args)
		end

	
	def initialize(args={})
		@name = args[:name] || ""
		@cusine = args[:cusine] || ""
		@price = args[:price]  || ""
	end

	def import_line(line)
		line_array = line.split("\t")
		@name, @cusine, @price = line_array
		return self
	end		

	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath, 'a') do |file|
			file.puts "#{[@name, @cusine, @price].join("\t")}\n"
	end
		return true
	end
	def formatted_price
		number_to_currency(@price)
	end


end