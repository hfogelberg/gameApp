Template.adultsGameTemplate.created = ->
	Session.set('counter', 0)
	Session.set('correctAnswersCounter', 0)

	Deps.autorun ->
		Meteor.call 'getAdultQuestions', (error, result) ->
			if error
				alert 'Error'
			else
				Session.set('questions', result)

Template.adultsGameTemplate.helpers
	questionType: ->
		Session.get 'questionType'
		
	correctAnswers: ->
		console.log Session.get 'correctAnswersCounter'
		Session.get('correctAnswersCounter')

	getCountdown: ->
		Session.get('time')
		
	question:->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]

Template.adultsGameTemplate.events
	'click #btnNextQuestion': ->
		i = Session.get('counter') + 1
		Session.set('counter', i)

	'click .btnAnswer': (event)->
		console.log 'btnAnswer'
		answerId = event.currentTarget.id
		elem = $('#explanation_' + answerId)
		elem.removeClass('hidden')
		Meteor.call 'countScores', (answerId), ->

