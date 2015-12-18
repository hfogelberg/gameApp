Template.changeAdultAnswerTemplate.helpers
	id: ->
		Session.get 'answerId'

	questionId: ->
		Session.get 'questionId'

	thumbRoot: ->
		Session.get 'thumbRoot'

Template.changeAdultAnswerTemplate.events
	'click .btnChangeAnswer': (event) ->
		event.preventDefault
		
		isCorrectAnswer = NO
		if $('#isCorrectAnswer').is(":checked") then isCorrectAnswer =  YES

		params = {
			answers:{
				answerId: Session.get('answerId')
				answerTitle: $('#answerTitle').val()
				reason: $('#explanation').val()
				isCorrectAnswer: isCorrectAnswer
			}
		}

		console.log params

		Meteor.call 'changeAnswerToQuestion', Session.get('questionId'), Session.get('answerId'), params, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'

		Router.go('/admin')