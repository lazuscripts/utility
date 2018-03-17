exists = (file_path) ->
  if file = io.open file_path, "r"
    file\close!
    return true
  else
    return false

size = (file_or_path) ->
  if "string" == type file_or_path
    file = io.open file_or_path, "r"
    size = file\seek "end"
    file\close!
    return size
  else
    current = file\seek!
    size = file\seek "end"
    file\seek "set", current
    return size

{
  :exists
  :size
}
