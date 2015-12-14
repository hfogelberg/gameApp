Template.questionTemplate.events
	'click .btnRemoveAnswer': (event) ->
		event.preventDefault
		answerId =  event.currentTarget.id;

		Meteor.call 'removeAnswer', Session.get('questionId'), answerId, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'

			