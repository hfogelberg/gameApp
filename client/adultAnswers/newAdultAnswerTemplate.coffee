Template.newAdultAnswerTemplate.helpers
	questionId: ->
		Session.get 'questionId'

Template.newAdultAnswerTemplate.events
	'click .btnAddAnswer':(event) ->
		event.preventDefault

		isCorrectAnswer = NO
		if $('#isCorrectAnswer').is(":checked") then isCorrectAnswer = YES

		params = {
			answers: {
				answerId: Random.id()
				answerTitle: $('#answerTitle').val()
				reason: $('#explanation').val()
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