require 'rjb'

class AI
  def initialize
    Rjb::load(File.dirname(__FILE__) + "/con4.jar", jvmargs = [""])
    @ai = Rjb::import('ConnectFour').new
  end

  def move
    @ai.bestmove
  end

  def play(col)
    @ai.play(col)
  end
    

end
