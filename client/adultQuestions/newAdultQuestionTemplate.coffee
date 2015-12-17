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
			level: ADULT
			createdDate: new Date()
			updatedDate: new Date()
			random: Random.fraction()
		}

		Meteor.call 'createQuestion', props, (err) ->