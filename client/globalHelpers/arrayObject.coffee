Template.registerHelper 'arrayObject', (obj) ->
  result = []
  for key of obj
    result.push
      name: key
      value: obj[key]
  result