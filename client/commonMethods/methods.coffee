Meteor.methods
	'resetDivs': ()->
		$('.oneAnswerContainer').removeClass('invisible')
		$('.answerTitle').removeClass('invisible')
		$('.btnChildAnswer').removeClass('invisible')

	'setupQuestionType1': ()->
		console.log 'setupQuestionType1'
		$('.answerTitle').addClass('invisible')
		$('.oneAnswerContainer').addClass('invisible')
		#$('.btnChildAnswer').attr('disabled', true)
		#$('#btnNextQuestion').attr('disabled', true)
		$('#btnNextQuestion').removeClass('invisible')
		$('#timer').removeClass('invisible')
		#$('#btnSkipClock').removeClass('invisible')

	'setupQuestionType2': ()->
		$('.oneAnswerContainer').addClass('invisible')
		#$('.btnChildAnswer').attr('disabled', true)
		#$('#btnNextQuestion').attr('disabled', true)
		$('#btnNextQuestion').removeClass('invisible')
		$('#timer').removeClass('invisible')
		#$('#btnSkipClock').removeClass('invisible')

	'setupQuestionType3': ()->
		#$('.btnChildAnswer').attr('disabled', true)
		#$('#btnNextQuestion').attr('disabled', true)
		$('#btnNextQuestion').removeClass('invisible')
		$('#timer').removeClass('invisible')
		#$('#btnSkipClock').removeClass('invisible')

	'setupQuestionType4': ()->
		#$('.btnChildAnswer').attr('disabled', false)
		#$('#btnNextQuestion').addClass('invisible')
		#('#btnNextQuestion').attr('disabled', true)
		$('#timer').addClass('invisible')
		#$('#btnSkipClock').addClass('invisible')

	'setupQuestionType5': ()->
		$('.answerTitle').addClass('invisible')

	'displayAnswerType1': ()->
		$('.answerTitle').removeClass('invisible')
		#$('.btnChildAnswer').attr('disabled', true)
		$('#btnNextQuestion').attr('disabled', false)

	'displayAnswerType2': ()->
		$('.oneAnswerContainer').removeClass('invisible')
		#$('.btnChildAnswer').attr('disabled', true)
		$('#btnNextQuestion').attr('disabled', false)

	#Fade out wrong answers
	'displayAnswerType3': ()->
		#$('.btnChildAnswer').attr('disabled', true)
		$('.wrongAnswer').addClass('invisible')
		$('#btnNextQuestion').attr('disabled', false)

	'displayAnswerType4': ()->
		$('.btnChildAnswer').removeClass('invisible')
		$('.btnChildAnswer').attr('disabled', false)
		$('.wrongAnswer').removeClass('invisible')


	# Check if answer is correct and increment scores counter
	'countScores': (answerId) ->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]
		for answer in question.answers
			if answer.answerId is answerId
				Session.set('explanation', answer.reason)
				if answer.isCorrectAnswer is YES
					$('#myModalLabel').removeClass('badAnswerColor')
					$('#myModalLabel').addClass('goodAnswerColor')
					Session.set('isRightAnswer', CORRECT_ANSWER_TEXT)
					n = Session.get('correctAnswersCounter') + 1
					Session.set('correctAnswersCounter', n)
				else
					$('#myModalLabel').removeClass('goodAnswerColor')
					$('#myModalLabel').addClass('badAnswerColor')
					Session.set('isRightAnswer', WRONG_ANSWER_TEXT)
					n = Session.get('wrongAnswersCounter') + 1
					Session.set('wrongAnswersCounter', n)

	# Time to check what kind of question it is and hide/show divs
	'findQuestionType': ->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]

		len = question.oneAnswerText.length

		Session.set('questionType', QUESTION_TYPE_5)
		console.log question.showAnswer
		console.log question.questionType
		console.log question.correctAnswers
		console.log question.oneAnswerText.length
		console.log question.image

		$('.intro-body .container').addClass('centered')

		if question.image
			$('.intro-body .container').removeClass('centered')

		if question.showAnswer is NO
			if question.questionType is SHOW
				if question.oneAnswerText.length == 0
					if question.correctAnswers is ALL
						Session.set('questionType', QUESTION_TYPE_1)
						console.log "hello1"
		#Type 2
		if question.questionType is SHOW
			if question.oneAnswerText.length > 0
				if question.correctAnswers is ALL
					Session.set('questionType', QUESTION_TYPE_2)
					console.log "hello2"
		#Type 3
		if question.questionType is SHOW
			if question.showAnswerTimer.length > 0
				if question.correctAnswers is ONE
					Session.set('questionType', QUESTION_TYPE_3)
					console.log "hello3"
		#Type 4
		if question.questionType is CHOOSE
			if question.correctAnswers is ONE
				Session.set('questionType', QUESTION_TYPE_4)
				console.log "hello4"

		if question.questionType is CHOOSE
			if question.correctAnswers is ALL
				Session.set('questionType', QUESTION_TYPE_5)
				console.log "hello5"

		console.log Session.get('questionType')

		if Session.get('questionType') is QUESTION_TYPE_1
			Meteor.call 'setupQuestionType1', () ->
		if Session.get('questionType') is QUESTION_TYPE_2
			Meteor.call 'setupQuestionType2', () ->
		if Session.get('questionType') is QUESTION_TYPE_3
			Meteor.call 'setupQuestionType3', () ->
		if Session.get('questionType') is QUESTION_TYPE_4
			Meteor.call 'setupQuestionType4', () ->
		if Session.get('questionType') is QUESTION_TYPE_5
			Meteor.call 'setupQuestionType5', () ->

