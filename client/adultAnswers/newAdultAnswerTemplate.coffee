Template.newAdultAnswerTemplate.helpers
	questionId: ->
		Session.get 'questionId'

Template.newAdultAnswerTemplate.events
	'click .btnDeleteAnswer': (event) ->
		event.preventDefault

		if (confirm('Are you sure you want to remove the answer?'))
			answerId =  event.currentTarget.id
			Meteor.call 'removeAnswer', Session.get('questionId'), answerId, (err) ->
				if err
					console.log err


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