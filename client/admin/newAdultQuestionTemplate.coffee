questionId = Random.id()

Template.newAdultQuestion.helpers
	questionId: ->
		return questionId

Template.newAdultQuestion.events
	'click .btnSaveQuestion': (event) ->
		event.preventDefault

		props = {
			_id: questionId
			title: $('#title').val()
			explanation: $('#explanation').val()
			reason: $('#reason').val()
			level: ADULT
			createdDate: new Date()
			updatedDate: new Date()
			random: Random.fraction()
		}

		console.log props

		Meteor.call 'createQuestion', props, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'