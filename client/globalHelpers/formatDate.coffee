Template.registerHelper 'formatDate', (date) ->
  moment(date).format 'YYYY-MM-DD'