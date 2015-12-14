Template.newAdultAnswerTemplate.events
	'click .btnAddAnswer':(event) ->
		event.preventDefault
		alert 'click'

		isCorrectAnswer = false
		if $('#isCorrectAnswer').checked then isCorrectAnswer = true

		params = {
			answers: {
				answerId: Random.id()
				answerTitle: $('#answerTitle').val()
				reason: $('#reason').val()
				isCorrectAnswer: isCorrectAnswer
			}
		}

		console.log params

		Meteor.call 'addAnswerToQuestion', this._id, params, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'

		$('#answerForm')[0].reset()