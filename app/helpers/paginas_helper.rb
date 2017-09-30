# app/helpers/paginas_helper.rb
module PaginasHelper
  # params:
        #   ext - file extension
  # ==== Examples
  # lines_of_code(rb)
  # lines_of_code(html)
  # Returns a number of lines of codes based on parameter
  def lines_of_code(ext)


    o = 0 # Number of files
    n = 0 # Number of lines of code
    m = 0 # Number of lines of comments

    files = Dir.glob('./**/*.' + ext)

    files.each do |f|
      next if f.index('vendor')
      next if FileTest.directory?(f)
      o += 1
      i = 0
      File.new(f).each_line do |line|
        if line.strip[0] == '#'
          m += 1
          next
        end
        i += 1
      end
      n += i
    end

    puts "#{o.to_s} files."
    puts "#{n.to_s} lines of code."
    puts "#{(n.to_f / o.to_f).round(2)} LOC/file."
    puts "#{m.to_s} lines of comments."
    n
  end
# Returns number of registrated users
  def users_ammount
    User.all.size
  end
end
