settings = {
  "githook.run_without_auth": true
  "fursimile.scrape.enabled": true
  "fursimile.scrape.e621.enabled": true
  "fursimile.scrape.e621.new_amount": 20
  "fursimile.scrape.e621.old_amount": 40
  "githook.save_logs": true
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
}

-- somehow break into table via periods, order alphabetically

recursive_builder = (input) ->
  for name, value in pairs(input)
    sep = name\find "%."
    parent = name:sub 1, sep-1
    child = name:sub sep+1
    recursive_builder table_made_of_child ?

settings.build = ->
  recursive_builder settings

VALUE = {} -- special key
prelim_struct = {
  somestring: {
    [VALUE]: nil or "whatever"
    somethingelse: {
      [VALUE]: false or nil
    }
    "another-name": {
      [VALUE]: "eureka"
    }
  }
}

VALUE = {}
result = {}
for name, value in pairs(settings)
  location = result
  sep = name\find "%."
  if sep
    -- walk the tree
    parent = name:sub 1, sep-1
    unless location[name]
      location[name] = {}
    child = name:sub sep+1
    -- somehow call recursively on child name w parent as reference
  else
    if location[name]
      location[name][VALUE] = value
    else
      location[name] = {
        [VALUE]: value
      }

-- I believe this one will work
VALUE = {}
hierachical_table = {}
set = (location, name, value) ->
  unless location[name]
    location[name] = {}
  if value
    location[name][VALUE] = value
  return location[name]
recursor = (location, name, value) ->
  sep = name\find "%."
  if sep
    parent = name\sub 1, sep-1
    location = set location, parent, nil
    child = name\sub sep+1
    recursor location, child, value
  else
    set location, name, value
for name, value in pairs(settings)
  location = hierachical_table
  recursor location, name, value

struct = {
  name: "somestring"
  value: false or nil
  { -- ordering of these should be based on alphabetical sort of their names
    name: "somethingelse"
    value: nil or "cheese"
    -- each level can have as many sub-levels as you want
  }
  {
    name: "another-sub-category-thing"
    value: true
  }
}

get_location = (tab, name) ->
  for value in *tab
    if value.name == name
      return value
result = {}
for name, value in pairs(settings)
  location = result
  sep = name\find "%."
  while sep
    parent = name:sub 1, sep-1
    child = name:sub sep+1
    new_location = get_location location, parent
    unless new_location
      table.insert location, {
        name: parent
        value: fuckme
      }
    -- unless location[parent]
    --   location[parent] = {
    --     name: parent
    --   }

-- return settings

--------------------------------------------------------------------------------

VALUE = {}
result = {}

current = {}
set = (name, value) ->
  unless current[name]
    current[name] = {}
  if value
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
  recurse name, value
