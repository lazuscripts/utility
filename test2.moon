settings = {
  "githook.run_without_auth": true
  "githook.save_logs": true
  "fursimile.scrape.enabled": true
  "fursimile.scrape.e621.enabled": true
  "fursimile.scrape.e621.new_amount": 20
  "fursimile.scrape.e621.old_amount": 40
  "fursimile.scrape": "hidden value that should appear!"
  "users.require_email": true
  "users.minimum_password_length": 12
  "users.maximum_character_repetitions": 7
  "users.admin_only": false
  "users.allow_signup": true
  "test.string_value": "Here's a string!"
  "test.hierachy": "This should show above its sub-components."
  "test.hierachy.a": 1
  "test.hierachy.b": 2
  "top_level": true
  "xxyyzz": "aabbcc"
  "not_a_real_value": nil
}

VALUE = {}
result = {}

current = {}
set = (name, value) ->
  unless current[name]
    current[name] = {}
  if value ~= nil
    current[name][VALUE] = value
  return current[name]

recurse = (name, value) ->
  if sep = name\find "%."
    current = set name\sub 1, sep-1
    recurse name\sub(sep+1), value
  else
    set name, value

for name, value in pairs(settings)
  current = result
  recurse name, tostring value

---

result2 = {}
current2 = {}

recurse2 = (tab) ->
  sortOrder = {}
  for k,v in pairs tab
    if k != VALUE
      table.insert sortOrder, k
  table.sort sortOrder

  for index, name in ipairs sortOrder
    the_tab = tab[name]

  current2
  -- create entries in result2 at current2

recurse2 current

---------------
p2 = (k) ->
  if k == VALUE
    return ""
  else
    return k

p = (t, d=0) ->
  for k,v in pairs(t)
    if "table" == type v
      print string.rep("\t", d), p2(k), ":"
      p v, d+1
    else
      print string.rep("\t", d), p2(k), v

p result2

return {
  :VALUE
  :result
  :result2
  :settings
  :p
}
