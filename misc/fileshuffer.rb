puts "Give your file name"
file = gets.chomp
shuffled_contents = File.readlines(file).shuffle
File.open("#{file[0,file.length-4]}-shuffled.txt", 'w') do |f|
  shuffled_contents.each { |line| f.puts line }
end