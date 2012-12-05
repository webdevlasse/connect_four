class Col < Array

  def place(player)
    if available?
      indexes = [self.rindex(0), self.rindex(1)]
      index = indexes.map! { |index| index.nil? ? -1 : index }.max
      index == -1 ? self[0] = player : self[index+1] = player
      return true
    end
    false
  end

  def available?
    self.include?("b")
  end

end