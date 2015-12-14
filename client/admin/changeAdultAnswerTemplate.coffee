Template.changeAdultAnswerTemplate.helpers
	id: () ->
		Session.get 'answerId'


Template.changeAdultAnswerTemplate.events
	'click .btnChangeAnswer': (event) ->
		event.preventDefault
		alert 'change'
		
		isCorrectAnswer = false
		if $('#isCorrectAnswer').is(":checked") then isCorrectAnswer = true

		alert Session.get('answerId')
		alert $('#answerTitle').val()
		alert $('#explanation').val()
		alert isCorrectAnswer

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