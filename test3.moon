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

sortOrder = {}
for k,v in pairs settings
  table.insert sortOrder, k
table.sort sortOrder

current = ""
for _,name in ipairs sortOrder
  value = settings[name]
  -- TODO now is it part of our current 'result' or not?
  print name, value
