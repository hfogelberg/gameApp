Template.questionTemplate.helpers
	thumbRoot:->
		Session.get 'thumbRoot'
		
	questionId: ->
		Session.get('questionId')

Template.questionTemplate.events
	'click .btnRemoveAnswer': (event) ->
		event.preventDefault
		answerId =  event.currentTarget.id;

		Meteor.call 'removeAnswer', Session.get('questionId'), answerId, (err) ->
			if err
				console.log err

			