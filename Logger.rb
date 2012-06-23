class Logger
  include Singleton
   
  def initialize
    @log = File.open("./log.txt", "a")
  end
 
  def log(msg)
    @log.puts(msg)
  end
end