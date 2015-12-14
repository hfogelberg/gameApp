Template.registerHelper 'addIndex', (thatArray) ->
  if thatArray and thatArray.length
    $.each thatArray, (position, thatObject) ->
      thatObject.index = position
      thatArray[position] = thatObject
      return
    return thatArray
  return