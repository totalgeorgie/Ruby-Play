#!/usr/bin/env
def say_hello(name)
  puts "Hey there, #{name}!"
end

if $PROGRAM_NAME == __FILE__
  name = gets.chomp
  say_hello(name)
end