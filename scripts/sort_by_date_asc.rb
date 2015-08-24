file = ARGV.first

lines = File.readlines(file)
first_indexes = []
no_sorted_indexes = []
lines.each_with_index do |line, i|
  first_indexes << i if line.strip[0] != "*"
  no_sorted_indexes <<  i if line.strip[0] == "*" && line.match(/.+hab.+post\/.+/).nil?
end
listed_lines = lines.select{ |line| line.strip[0] == "*" && !line.strip.match(/.+habrahabr.ru\/post\/(\d)+\//).nil? }
listed_lines.sort!{|a,b| a[/.+post\/((\d)+)/, 1].to_i <=> b[/.+post\/((\d)+)/, 1].to_i}

written_strings = []
first_indexes.each { |i| written_strings << lines[i] }
listed_lines.each { |line| written_strings << line }
no_sorted_indexes.each { |i| written_strings << lines[i] }
File.open(file, "w") do |f|
  written_strings.each {|curr| f.write curr}
end
