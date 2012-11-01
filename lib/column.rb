class Column < Array

  def place(player, num_rows)
    if available?(num_rows)
      self << player
      return true
    end
    false
  end

  def available?(num_rows)
    self.length != num_rows
  end

end