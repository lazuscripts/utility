import json_params, capture_errors, yield_error from require "lapis.application"
import insert from table
import max from math

request = (fn) ->
  json_params capture_errors {
    fn,
    on_error: =>
      status = 400
      errors = {}
      for err in *@errors
        if "table" == type err
          status = max status, err[1]
          insert errors, err[2]
        else
          insert errors, err
      return(:status, json: { :errors })
  }

abort = (status, message) ->
  if message
    yield_error {status, message}
  else
    yield_error status

assert_model = (result, err) ->
  abort 500, err if err
  return result

{
  :request
  :abort
  :assert_model
}
