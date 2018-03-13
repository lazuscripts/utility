escape_similar_to = (str) ->
  -- matches any of %_\|*+?{}()[]
  -- puts a backslash in front of them
  str = str\gsub "[%%_\\|%*%+%?{}%(%)%[%]]", "\\%1"
  return str -- return on seperate line to avoid returning 2nd value from gsub

{
  :escape_similar_to
}
