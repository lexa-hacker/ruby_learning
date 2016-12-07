file_name_read = ARGV[0]
file_name_write = ARGV[1]

f_read = File.new(file_name_read)
f_write = File.new(file_name_write, "w")

while str=f_read.gets
  unless str["</"] || str["/>"] || str["<?"] || str.chomp.empty?
    if ind = str.index("name")
      str = str[ind+6,str.length-1]
      str = str[0,str.index("\"")]
      f_write.puts(str)
    end
  end
end

f_read.close
f_write.close