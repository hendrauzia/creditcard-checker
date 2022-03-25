class String
  def integer?
    regex = /
      \A    # start of string
      [-+]? # numeric sign
      \d+   # numeric digits 0 to 9
      \z    # end of string
    /x

    regex === self
  end
end
