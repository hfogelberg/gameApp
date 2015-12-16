clock = 0

timeLeft = (t)->
  if clock > 0
    clock--
    Session.set "time", clock
    console.log clock
  else
  	#Check type of question and display divs with answer
  	questionType = Session.get('questionType')
  	if questionType == QUESTION_TYPE_1
  		Meteor.call 'displayAnswerType1', ->
  	if questionType == QUESTION_TYPE_2
  		Meteor.call 'displayAnswerType2', ->
  	if questionType == QUESTION_TYPE_3
  		Meteor.call 'displayAnswerType3', ->
  	if questionType == QUESTION_TYPE_4
  		Meteor.call 'displayAnswerType4', ->
  	if questionType != QUESTION_TYPE_4
  		alert questionType
  		$('.btnAnswer').attr('disabled', 'disabled')

Meteor.setInterval(timeLeft, 1000)

Template.kidsGameTemplate.created = ->
	Session.set('counter', 0)
	Session.set('time', 0)
	Session.set('correctAnswersCounter', 0)

	Deps.autorun ->
		Meteor.call 'getKidsQuestions', (error, result) ->
			if error
				alert 'Error'
			else
				Session.set('questions', result)

Template.kidsGameTemplate.helpers
	numQuestions: ->
		Session.get('questions').length

	explanation: ->
		Session.get 'explanation'

	isRightAnswer: ->
		Session.get 'isRightAnswer'

	question:->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]
		
	questionType: ->
		Session.get 'questionType'

	getCountdown:->
		Session.get 'time'

	answerGiven:->
		Session.get 'answerGiven'

	correctAnswers:->
		Session.get 'correctAnswers'

	correctAnswers: ->
		Session.get('correctAnswersCounter')

	getCountdown: ->
		Session.get('time')
		
	question:->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]
		Meteor.call 'resetDivs', ->

		Meteor.call 'findQuestionType', ->

		if question.showAnswerTimer
			clock = question.showAnswerTimer
			# interval = Meteor.setInterval(clock, 1000)
			Meteor.setInterval(clock, 1000)
		else
			console.log 'No need to start timer'
		return question

Template.kidsGameTemplate.events
	'click #btnNextQuestion': (event) ->
		event.preventDefault

		# Meteor.clearInterval interval
		i = Session.get('counter') + 1
		Session.set('counter', i)

		if i >= Session.get('questions').length		
			Router.go('/thanks')

	'click .btnAnswer': (event)->
		console.log 'btnAnswer'
		answerId = event.currentTarget.id
		Meteor.call 'countScores', (answerId), ->

		if Session.get 'questionType' == QUESTION_TYPE_3
  		Meteor.call 'displayAnswerType3', ->

 