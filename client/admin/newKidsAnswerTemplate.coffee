Template.newKidsAnswerTemplate.events
	'click .btnSaveAnswer': (event) ->
		event.preventDefault

		isCorrectAnswer = false
		if $('#isCorrectAnswer').checked then isCorrectAnswer = true


		answerParams = {
			answerTitle: $('#answerTitle').val()
			isCorrectAnswer: isCorrectAnswer

		}

		answers.push answerParams
		$('#answerForm')[0].reset();
		$('#kidsAnswerModal').modal('hide')
