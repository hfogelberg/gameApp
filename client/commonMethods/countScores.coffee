Meteor.methods
	# Check if answer is correct and increment scores counter
	'countScores': (answerId) ->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]
		for answer in question.answers
			if answer.answerId is answerId
				console.log 'Found answer'
				if answer.isCorrectAnswer is YES
					console.log 'Found correct answer'
					n = Session.get('correctAnswersCounter') + 1
					console.log 'Number of correct answers: ' + n
					Session.set('correctAnswersCounter', n)