Template.changeAnswerTemplate.helpers
	id: ->
		Session.get 'answerId'

Template.changeAnswerTemplate.events
	'click .btnChangeAnswer': (event) ->
		event.preventDefault
		
		isCorrectAnswer = false
		if $('#isCorrectAnswer').checked then isCorrectAnswer = true

		params = {
			answers:{
				answerId: Session.get('answerId')
				answerTitle: $('#answerTitle').val()
				isCorrectAnswer: isCorrectAnswer
				image: Session.get('answerImageId')
			}
		}

		console.log params

		Meteor.call 'changeAnswerToQuestion', Session.get('questionId'), Session.get('answerId'), params, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'

	