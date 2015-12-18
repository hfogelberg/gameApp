Template.questionTemplate.helpers
	thumbRoot:->
		Session.get 'thumbRoot'
		
	questionId: ->
		Session.get('questionId')

Template.questionTemplate.events
	'click .btnRemoveAnswer': (event) ->
		event.preventDefault

		if (confirm('Are you sure you want to remove the answer?'))
			answerId =  event.currentTarget.id
			Meteor.call 'removeAnswer', Session.get('questionId'), answerId, (err) ->
				if err
					console.log err

			