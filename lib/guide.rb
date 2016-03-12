require 'restaurant'
class Guide

	class Config
		@@actions = ['list','find','add','quit']
		def self.actions; @@actions;end
	end

	def initialize(path=nil)
		#locate the restaurent text file at path
		Restaurant.filepath = path
		if Restaurant.file_usable?
			puts "Found the file"					
		#Or create a new file if it doesn't exist
		elsif Restaurant.create_file
		puts "Created the file"

		#Exit if create fails
	else 
		puts "Exiting. \n\n"
		exit!
		end
	end

	def launch!
		introduction
			#Action loop
			#  What do you want to do ? (list, find , add, quit)
			result =nil 
				until result == :quit
					action = get_action
						#Do that action
					result= do_action(action)
					#repeat till user quits
				end

		conclusion
	end
	


	def get_action
		action = nil
		until Guide::Config.actions.include?(action)
			puts "Actions: " + Guide::Config.actions.join(", ") if 
				action
		print "Enter the option choice >  "
		user_response = gets.chomp
		action= user_response.downcase.strip
	end
		return action
	end

	def do_action(action)
		case action 
		when 'list'
			output_action_header("Listing the restraunts")
			list
		when 'find'
			output_action_header("Finding the restraunts")
			find
		when 'add'
			output_action_header("Adding the restraunts")
			add
		when 'help'
			
			print <<-HERE

<<<<< Food finder - Documentation >>>>>

			This application can perform 4 actions

			List ---> Prints the number of restraunts added

			Add ----> Adds restrurant to the list

			Find ---> Find the desired restaurant

			quit ----> quits the application

help ----> Displays the documentation


			HERE

		when 'quit'
			return :quit
		else
		puts "Please enter any of these commands: (list,find,add,quit)"
		end
	end

	def list
		restaurants = Restaurant.saved_restaurants
		restaurants.to_a.each do |rest|
			puts rest.name + ' | ' + rest.cusine + ' | ' + rest.formatted_price
					end
	end


	def add

		restaurant=Restaurant.build_from_questions

		if restaurant.save
			puts "Restaurant saved ! \n"
		else
			puts "Restaurant not saved\n"
	end


	end

	def introduction
	puts "\n\n<<< Welcome to Food Finder>>>\n\n"
	puts "This is an interactice guide to find food that you love :)\n "
	end

	def conclusion
	puts "\n<<<<< Good bye, Great day !>>>> \n\n\n"

	end
	def output_action_header(text)
		puts "\n#{text.upcase.center(60)}\n\n"

	end
	

end