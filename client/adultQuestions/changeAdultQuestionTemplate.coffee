Template.changeAdultQuestionTemplate.events
	'click .btnChangeQuestion': (event) ->
		event.preventDefault
		
		props = {
			title: $('#title').val()
			explanation: $('#explanation').val()
			level: ADULT
			createdDate: new Date()
		}

		Meteor.call 'changeQuestion', this._id, props, (err) ->