Template.thanks.rendered = ->
	$( ".modal-backdrop" ).remove()

Template.thanks.helpers
	correct: ->
		console.log Session.get 'correctAnswersCounter'
		Session.get('correctAnswersCounter')

	numQuestions: ->
		Session.get('questions').length