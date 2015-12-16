clock = 0

timeLeft = ->
  if clock > 0
    clock--
    Session.set "time", clock
    console.log clock
  else
  	#Check type of question and display divs with answer
  	questionType = Session.get('questionType')
  	if questionType == @QUESTION_TYPE_1
  		Meteor.call 'displayAnswerType1', ->
  	if questionType == @QUESTION_TYPE_2
  		Meteor.call 'displayAnswerType2', ->
  	if questionType == @QUESTION_TYPE_3
  		Meteor.call 'displayAnswerType3', ->

  	Meteor.clearInterval(interval)
  	# Meteor.call 'resetDivs', ()->

interval = Meteor.setInterval(timeLeft, 1000)

Template.kidsGameTemplate.created = ->
	Session.set('questionsCounter', 0)
	Session.set('time', 0)
	Session.set('correctAnswersCounter', 0)

	Deps.autorun ->
		Meteor.call 'getKidsQuestions', (error, result) ->
			if error
				alert 'Error'
			else
				Session.set('questions', result)

Template.kidsGameTemplate.helpers
	question:->
		questions = Session.get('questions')
		question = questions[Session.get('questionsCounter')]
		
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
		question = questions[Session.get('questionsCounter')]

		Meteor.call 'findQuestionType', ->

		if question.showAnswerTimer
			clock = question.showAnswerTimer
			interval = Meteor.setInterval(clock, 1000)
		else
			console.log 'No need to start timer'
		return question

Template.kidsGameTemplate.events
	'click #btnNextQuestion': (event) ->
		event.preventDefault

		Meteor.clearInterval interval
		i = Session.get('questionsCounter') + 1
		Session.set('questionsCounter', i)

	'click .btnAnswer': (event)->
		console.log 'btnAnswer'
		answerId = event.currentTarget.id
		Meteor.call 'countScores', (answerId), ->
