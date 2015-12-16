Meteor.methods
	'resetDivs': ()->
		$('.oneAnswerContainer').removeClass('invisible')
		$('.answerTitle').removeClass('invisible')
		$('.btnAnswer').removeAttr('disabled')
		$('.btnAnswer').removeClass('invisible')

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

	# Check if answer is correct and increment scores counter
	'countScores': (answerId) ->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]
		for answer in question.answers
			if answer.answerId is answerId
				Session.set('explanation', answer.reason)
				if answer.isCorrectAnswer is YES
					Session.set('isRightAnswer', CORRECT_ANSWER_TEXT)
					n = Session.get('correctAnswersCounter') + 1
					console.log 'Number of correct answers: ' + n
					Session.set('correctAnswersCounter', n)
				else
					Session.set('isRightAnswer', WRONG_ANSWER_TEXT)

		# Time to check what kind of question it is and hide/show divs
	'findQuestionType': ->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]

		len = question.oneAnswerText.length
		# Type 1
		if question.showAnswer is NO
			if question.questionType is SHOW
				if question.oneAnswerText.length == 0
					if question.correctAnswers is ALL
						console.log('questionType is ' + QUESTION_TYPE_1)
						Session.set('questionType', QUESTION_TYPE_1)

		#Type 2
		if question.showAnswer is NO
			if question.questionType is SHOW
				if question.oneAnswerText.length > 0
					if question.correctAnswers is ALL
						console.log('questionType is ' + QUESTION_TYPE_2)
						Session.set('questionType', QUESTION_TYPE_2)

		#Type 3
		if question.showAnswer is NO
			if question.questionType is SHOW
				if question.correctAnswers is ONE
					console.log('questionType is ' + QUESTION_TYPE_3)
					Session.set('questionType', QUESTION_TYPE_3)

		#Type 4
		if question.showAnswer is YES
			if question.questionType is CHOOSE
				if question.correctAnswers is ONE
					console.log('questionType is ' + QUESTION_TYPE_4)
					Session.set('questionType', QUESTION_TYPE_4)		

		if Session.get('questionType') is 1
			Meteor.call 'setupQuestionType1', () ->
		if Session.get('questionType') is 2
			Meteor.call 'setupQuestionType2', () ->

