clock = 0

timeLeft = (t)->
  if clock > 0
    clock--
    Session.set "time", clock
  else
  	#Check type of question and display divs with answer
  	questionType = Session.get('questionType')

  	if questionType == QUESTION_TYPE_1
  		Meteor.call 'displayAnswerType1', ->
  	else if questionType == QUESTION_TYPE_2
  		Meteor.call 'displayAnswerType2', ->
  	else if questionType == QUESTION_TYPE_3
  		Meteor.call 'displayAnswerType3', ->
  	else if questionType == QUESTION_TYPE_4
  	 	Meteor.call 'dibtnChildAnswersplayAnswerType4', ->

Meteor.setInterval(timeLeft, 1000)

Template.kidsGameTemplate.created = ->
	Session.set('counter', 0)
	Session.set('time', 0)
	Session.set('correctAnswersCounter', 0)

	$('#btnPreviousQuestion').attr('disabled', 'disabled')
	Deps.autorun ->
		Meteor.call 'getKidsQuestions', (error, result) ->
			if error
				console.console.log  'Error'
			else
				Session.set('questions', result)

Template.kidsGameTemplate.helpers
	imageRoot:->
		Session.get 'imageRoot'

	numQuestions: ->
		Session.get('questions').length

	isRightAnswer: ->
		Session.get 'isRightAnswer'

	question:->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]
		
	questionType: ->
		Session.get 'questionType'

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
			Meteor.setInterval(clock, 1000)

		return question

Template.kidsGameTemplate.events
	'click #btnPreviousQuestion': (event) ->
		event.preventDefault

		i = Session.get('counter') - 1
		Session.set('counter', i)

	'click #btnNextQuestion:enabled': (event) ->
		event.preventDefault

		# Meteor.clearInterval interval
		i = Session.get('counter') + 1
		Session.set('counter', i)

		if (Session.get('counter') > 0)
			$('#btnPreviousQuestion').removeAttr('disabled')

		if i >= Session.get('questions').length		
			Router.go('/thanks')

	'click .btnChildAnswer:enabled': (event)->
		answerId = event.currentTarget.id
		Meteor.call 'countScores', (answerId), ->

		if Session.get 'questionType' == QUESTION_TYPE_3
  		Meteor.call 'displayAnswerType3', ->

 