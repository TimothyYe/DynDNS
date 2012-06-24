class Logger
  include Singleton
   
  def initialize
    @log = File.open("./log.txt", "a")
  end
 
  def log(msg)
    @log.puts(Time.now.strftime("%Y-%m-%d %H:%M:%S  ") + msg)
  end
end