file_read_name = ARGV[0]
file_write_name = ARGV[1]

file_read = File.new(file_read_name)
file_write = File.new(file_write_name, "w")

while str = file_read.gets
  if str["template "]
    arr = str.split("\"")
    i=0
    while i < arr.length
      if arr[i]["name"]
        file_write.puts arr[i+1]
      end
      i+=1
    end
  end
end

file_read.close
file_write.close