import Settings from require "models"

totype = (str) ->
  if value = tonumber str
    return value
  if str == "true"
    return true
  if str == "false"
    return false
  if str == "nil"
    return nil
  return str

cache = {}

get = (name, create=true) ->
  setting = cache[name]
  unless setting
    setting = Settings\find :name
    if (not setting) and create
      setting = Settings\create :name
    cache[name] = setting

  if setting
    return setting
  else
    return nil, "failed to load '#{name}' setting"

local settings
settings = {
  get: (name, skip_index) ->
    unless name
      return settings.load!

    unless skip_index -- for metamethods to not loop endlessly
      return settings[name] if settings[name]

    setting, err = get name
    if setting
      value = totype setting.value
      settings[name] = value
      return value
    else
      return nil, err

  set: (name, value) ->
    unless name
      return settings.save!

    setting, err = get name
    if setting
      settings[name] = value
      return setting\update value: tostring value
    else
      return nil, err

  save: (name) ->
    if name
      setting, err = get name
      if setting
        return setting\update value: tostring settings[name]
      else
        return nil, err

    else
      for name, value in pairs settings
        switch name
          when "get", "set", "save", "load", "delete"
            nil
          else
            t = type value
            if t == "function" or t == "table"
              return nil, "cannot save '#{name}' setting, type '#{t}' not supported"
            else
              unless cache[name]
                cache[name] = Settings\find :name
                unless cache[name]
                  cache[name] = Settings\create :name

    for name, setting in pairs cache
      _, err = setting\update value: tostring settings[name]
      return nil, err if err
    return true

  load: (name) ->
    return settings.get name if name

    all_settings = Settings\select "WHERE true"
    for setting in *all_settings
      name = setting.name
      cache[name] = setting
      settings[name] = totype setting.value
    return settings

  delete: (name) ->
    if setting = get name, false
      if setting\delete!
        cache[name] = nil
        settings[name] = nil
      else
        return nil, "failed to delete '#{name}' setting"
    return true
}

return setmetatable settings, {
    __call: (t, name) ->
      return settings.get name, true
    __index: (t, name) ->
      return settings.get name, true
  }
