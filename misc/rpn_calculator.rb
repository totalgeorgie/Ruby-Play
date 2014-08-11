#!/usr/bin/env ruby


class RPNCalculator

attr_accessor :calculator

	def initialize()
		@calculator=[]
	end
	
	def push(x)
		@calculator << x
	end
	
	def value
		@calculator.last
	end
	
	def plus
			if @calculator.size>=2
			sum=@calculator.pop + @calculator.pop
			@calculator << sum
		else
			raise "calculator is empty"
		end
	end

	def minus
			if @calculator.size>=2
			sec=@calculator.pop
			first=@calculator.pop
			diff=first-sec
			@calculator << diff
		else
			raise "calculator is empty"
		end
	end
	
	def divide
			if @calculator.size>=2
			x1=@calculator.pop.to_f
			x2=@calculator.pop.to_f
			x3=x2 / x1
			@calculator << x3
		else
			raise "calculator is empty"
		end
	end
	
	def times
		if @calculator.size>=2
			x=@calculator.pop.to_f
			y=@calculator.pop.to_f
			z=x * y
			@calculator << z
		else
			raise "calculator is empty"
		end
	end
	
  def tokens(x)
  	arr=x.split(" ")
  	y=arr.collect do |a|
  		if (a== "+" || a== "-" || a== "*" || a== "/")
        a.to_sym
  		else
  		  a.to_i
  	  end
  	end
  	y
  end
	
	def evaluate(y)
		 tokens(y).each do |s|
			if s==:+
			 self.plus
			elsif s==:-
			  self.minus
			elsif s==:/
			  self.divide
			elsif s==:*
			  self.times
			else
			  self.push(s)
			end
		end
		self.value
	end
end

puts '__FILE__ - ' + __FILE__
puts '$PROGRAM_NAME - ' + $PROGRAM_NAME

if $PROGRAM_NAME == __FILE__
  user_calculator = RPNCalculator.new
  
  puts 'Im in here'
  # user_calculator.run
  # if ARGV[0] != nil
 #    File.foreach(ARGV[0]) do |expression|
 #      user_calculator.evaluate(expression)
 #      puts user_calculator.value
 #    end
 #  else
 #    evaluate_string = ""
 #    loop do
 #      input = gets.chomp
 #      if input == ""
 #        user_calculator.evaluate(evaluate_string)
 #        puts user_calculator.value
 #      else
 #        evaluate_string += "#{input} "
 #      end
 #    end
 #  end
end
