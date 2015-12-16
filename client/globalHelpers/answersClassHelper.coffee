Template.registerHelper 'getAnswerStatusClass', (isCorrectAnswer) ->
	if isCorrectAnswer is YES
		return CORRECT_ANSWER
	else
		return WRONG_ANSWER