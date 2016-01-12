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

Template.statsTemplate.events
  'click .btnResetStats':(event)->
    event.preventDefault
    
    if confirm 'Are you sure you want to reset the statistics?'
      Meteor.call 'resetStats', (err) ->
        if err
          console.log err
        else
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
    total = correct + Session.get('kidsWrongAnswers') + Session.get('adultsWrongAnswers')
    if total > 0
      return Math.round(correct/total * 100)
    else
      return 0

  kidsPercentTrue: ->
    correct = Session.get('kidsCorrectAnswers')
    total = correct + Session.get('kidsWrongAnswers')
    if total > 0
      return  Math.round(correct/total * 100)
    else
      return 0

  adultPercentTrue: ->
    correct = Session.get('adultsCorrectAnswers')
    total = correct +  Session.get('adultsWrongAnswers')
    if total > 0
      return Math.round(correct/total * 100)
    else
      return 0

  totalPercentFalse: ->
    wrong = Session.get('kidsWrongAnswers') + Session.get('adultsWrongAnswers')
    total = wrong + Session.get('kidsCorrectAnswers') + Session.get('adultsCorrectAnswers')
    if total > 0
      return Math.round(wrong/total * 100)
    else
      return 0

  kidsPercentFalse: ->
    wrong = Session.get('kidsWrongAnswers')
    total = wrong + Session.get('kidsCorrectAnswers')
    if total > 0
      return Math.round(wrong/total * 100)
    else
      return 0

  adultPercentFalse: ->
    wrong = Session.get('adultsWrongAnswers')
    total = wrong + Session.get('adultsCorrectAnswers')
    if total > 0
      return Math.round(wrong/total * 100)
    else
      return 0

Template.statsTemplate.onRendered ->
  elem = $('.adminNav li')
  elem.removeClass('active')
  elem = $('.stats')
  elem.addClass('active')
    
  ctxTotals = document.getElementById('totalsChart').getContext('2d')
  ctxKids = document.getElementById('kidsChart').getContext('2d')
  ctxAdults = document.getElementById('adultsChart').getContext('2d')

  totalData = [
    {
      value: Session.get('kidsWrongAnswers') + Session.get('adultsWrongAnswers')
      color: '#F7464A'
      label: 'False'
    }
    {
      value: Session.get('kidsCorrectAnswers') + Session.get('adultsCorrectAnswers')
      color: '#46BFBD'
      highlight: '#5AD3D1'
      label: 'True'
    }
  ]
  
  kidsData = [
    {
      value: Session.get('kidsWrongAnswers')
      color: '#F7464A'
      label: 'False'
    }
    {
      value: Session.get('kidsCorrectAnswers')
      color: '#46BFBD'
      label: 'True'
    }
  ]

  adultsData = [
    {
      value: Session.get('adultsWrongAnswers')
      color: '#F7464A'
      label: 'False'
    }
    {
      value: Session.get('adultsCorrectAnswers')
      color: '#46BFBD'
      label: 'True'
    }
  ]
  
  totalChart = new Chart(ctxTotals).Doughnut(totalData)
  kidChart = new Chart(ctxKids).Doughnut(kidsData)
  adultChart = new Chart(ctxAdults).Doughnut(adultsData)

  