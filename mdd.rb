require 'date'
require 'fileutils'
WEEKDAYS = %w{- Mon Tue Wed Thu Fri Sat Sun}

def mdd(dir, days)
  today = Date.today
  days.times do |i|
    day = today + i
    path = "#{dir}/#{day.iso8601.gsub('-', '/')}.md"
    raise "#{path} already exists!" if File.exist?(path)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path,
	       "# #{day.iso8601} #{WEEKDAYS[day.cwday]} W#{day.cweek} D#{day.yday}\n")
  end
end

if ARGV.size == 2
  mdd(ARGV[0], ARGV[1].to_i)
else
  print <<-EOS
ruby mdd.rb {directory} {days}
   create empty markdown diary for specified days from today
   in the specified directory e.g., ruby mdd.rb . 100
  EOS
end
