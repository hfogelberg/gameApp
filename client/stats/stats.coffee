random = ->
  Math.floor Math.random() * 100 + 1


Template.statsTemplate.created =->
  Deps.autorun ->
    Meteor.call 'getGamesCountByLevel', KID, (error, result) ->
      Session.set('kidsGameCount', result)

    Meteor.call 'getGamesCountByLevel', ADULT, (error, result) ->
      Session.set('adultsGameCount', result)

    Meteor.call 'getCorrectAnswersCount', KID, (error, result) ->
      Session.set('kidsCorrectAnswers', result)
    
    Meteor.call 'getCorrectAnswersCount', ADULT, (error, result) ->
      Session.set('adultsCorrectAnswers', result)

    Meteor.call 'getWrongAnswersCount', KID, (error, result) ->
      Session.set('kidsWrongAnswers', result)
    
    Meteor.call 'getWrongAnswersCount', ADULT, (error, result) ->
      Session.set('adultsWrongAnswers', result)

Template.statsTemplate.helpers
  totalGameCount: ->
    Session.get('kidsGameCount') + Session.get('adultsGameCount')

  kidsGameCount: ->
    Session.get 'kidsGameCount'

  adultsGameCount: ->
    Session.get 'adultsGameCount'

  kidsCorrectAnswers: ->
    Session.get 'kidsCorrectAnswers'

  adultsCorrectAnswers: ->
    Session.get 'adultsCorrectAnswers'

  kidsWrongAnswers: ->
    Session.get 'kidsWrongAnswers'

  adultsWrongAnswers: ->
    Session.get 'adultsWrongAnswers'

  totalPercentTrue: ->
    correct = Session.get('kidsCorrectAnswers') + Session.get('adultsCorrectAnswers')
    total = Session.get('kidsGameCount') + Session.get('adultsGameCount')
    return correct/total * 10

  kidsPercentTrue: ->
    correct = Session.get('kidsCorrectAnswers')
    total = Session.get('kidsGameCount')
    return correct/total * 10

  adultPercentTrue: ->
    correct = Session.get('adultsCorrectAnswers')
    total = Session.get('adultsGameCount')
    return correct/total * 10

  totalPercentFalse: ->
    wrong = Session.get('kidsWrongAnswers') + Session.get('adultsWrongAnswers')
    alert wrong
    total = Session.get('kidsGameCount') + Session.get('adultsGameCount')
    alert total
    return wrong/total * 10

  kidsPercentFalse: ->
    wrong = Session.get('kidsWrongAnswers')
    total = Session.get('kidsGameCount')
    return wrong/total * 10

  adultPercentFalse: ->
    wrong = Session.get('adultsWrongAnswers')
    total = Session.get('adultsGameCount')
    return wrong/total * 10

Template.statsTemplate.onRendered ->
  # Get the context of the canvas element we want to select
  ctxTotals = document.getElementById('totalsChart').getContext('2d')
  ctxKids = document.getElementById('kidsChart').getContext('2d')
  ctxAdults = document.getElementById('adultsChart').getContext('2d')

  totalData = [
    {
      value: Session.get('kidsWrongAnswers') + Session.get('adultsWrongAnswers')
      color: '#F7464A'
      highlight: '#FF5A5E'
      label: 'Red'
    }
    {
      value: Session.get('kidsCorrectAnswers') + Session.get('adultsCorrectAnswers')
      color: '#46BFBD'
      highlight: '#5AD3D1'
      label: 'Green'
    }
  ]
  
  kidsData = [
    {
      value: Session.get('kidsWrongAnswers')
      color: '#F7464A'
    }
    {
      value: Session.get('kidsCorrectAnswers')
      color: '#46BFBD'
    }
  ]

  adultsData = [
    {
      value: Session.get('adultsWrongAnswers')
      color: '#F7464A'
    }
    {
      value: Session.get('adultsCorrectAnswers')
      color: '#46BFBD'
    }
  ]
  
  totalChart = new Chart(ctxTotals).Doughnut(totalData)
  kidChart = new Chart(ctxKids).Doughnut(kidsData)
  adultChart = new Chart(ctxAdults).Doughnut(adultsData)

  