clock = 0

timeLeft = ->
  if clock > 0
    clock--
    Session.set "time", clock
    console.log clock
  else
  	console.log "That's All Folks"
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
	Session.set('counter', 0)
	Session.set('time', 0)
	Session.set('correctAnswersCounter', 0)

	Deps.autorun ->
		Meteor.call 'getKidsQuestions', (error, result) ->
			if error
				alert 'Error'
			else
				Session.set('questions', result)
	
Meteor.methods
	'resetDivs': ()->
		$('.oneAnswerContainer').removeClass('invisible')
		$('.answerTitle').removeClass('invisible')

	'setupQuestionType1': ()->
		console.log 'setupQuestionType1'
		$('.answerTitle').addClass('invisible')
		$('.oneAnswerContainer').addClass('invisible')

	'setupQuestionType2': ()->
		console.log 'setupQuestionType2'
		$('.oneAnswerContainer').addClass('invisible')

	'displayAnswerType1': ()->
		console.log 'displayAnswerType1'
		$('.answerTitle').removeClass('invisible')

	'displayAnswerType2': ()->
		console.log 'displayAnswerType2'
		$('.oneAnswerContainer').removeClass('invisible')

	#Fade out wrong answers
	'displayAnswerType3': ()->
		console.log 'displayAnswerType2'
		$('.wrongAnswer').addClass('invisible')

		# Time to check what kind of question it is and hide/show divs
	'findQuestionType': ->
		console.log 'findQuestionType'

		questions = Session.get('questions')
		question = questions[Session.get('counter')]

		console.log question

		len = question.oneAnswerText.length
		console.log 'Length of text: ' + len

		# Type 1
		if question.showAnswerImg is YES
			if question.showAnswer is NO
				if question.questionType is SHOW
					if len == 0
						if question.correctAnswers is ALL
							console.log 'questionType is ' + QUESTION_TYPE_1
							Session.set('questionType', QUESTION_TYPE_1)

		#Type 2
		if question.showAnswerImg is YES
			if question.showAnswer is NO
				if question.questionType is SHOW
					if len > 0
						if question.correctAnswers is ALL
							console.log 'questionType is ' + QUESTION_TYPE_2
							Session.set('questionType', QUESTION_TYPE_2)

		#Type 3
		if question.showAnswerImg is YES
			if question.showAnswer is NO
				if question.questionType is CHOOSE
					if question.correctAnswers is ONE
						console.log 'questionType is ' + QUESTION_TYPE_3
						Session.set('questionType', QUESTION_TYPE_3)

		#Type 4

		console.log 'questionType is ' + Session.get('questionType')
		if Session.get('questionType') is 1
			Meteor.call 'setupQuestionType1', () ->
		if Session.get('questionType') is 2
			Meteor.call 'setupQuestionType2', () ->

Template.kidsGameTemplate.helpers
	questionType: ->
		Session.get 'questionType'

	correctAnswers: ->
		Session.get('correctAnswersCounter')

	getCountdown: ->
		Session.get('time')
		
	question:->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]

		Meteor.call 'findQuestionType', ->

		if question.showAnswerTimer
			clock = question.showAnswerTimer
			interval = Meteor.setInterval(clock, 1000)
		else
			console.log 'No need to start timer'
		return question
  	
Template.kidsGameTemplate.events
	'click #btnNextQuestion': ->
		i = Session.get('counter') + 1
		Session.set('counter', i)

	'click .btnAnswer': (event)->
		console.log 'btnAnswer'
		answerId = event.currentTarget.id
		Meteor.call 'countScores', (answerId), ->
