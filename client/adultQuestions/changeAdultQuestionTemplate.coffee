Template.changeAdultQuestionTemplate.events
	'click .btnChangeQuestion': (event) ->
		event.preventDefault
		
		props = {
			title: $('#title').val()
			explanation: $('#explanation').val()
			level: ADULT
			createdDate: new Date()
		}

		console.log props

		Meteor.call 'changeQuestion', this._id, props, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'