Template.kidsGameTemplate.rendered =->
	console.log 'rendered'
	$('ul.questionair li:first').removeClass('invisible')
	$('ul.questionair li:first').addClass('visible')
	Session.set('correctAnswers', 0)
	Session.set('nbrAskedQuestions', 0)
	Session.set('answerGiven', false)

Template.kidsGameTemplate.helpers
	answerGiven:->
		Session.get 'answerGiven'

	correctAnswers:->
		Session.get 'correctAnswers'