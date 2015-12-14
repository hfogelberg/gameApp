Template.adultsGameTemplate.rendered =->
	console.log 'rendered'
	$('ul.questionair li:first').addClass('visible')
	Session.set('correctAnswers', 0)

Template.adultsGameTemplate.helpers
	correctAnswers:->
		Session.get 'correctAnswers'

Template.adultsGameTemplate.events
	'click .btnAnswer': (event) ->
		event.preventDefault

		answerId = event.currentTarget.id

		console.log  'Selected answer: ' + answerId
		elem = '.explanation#' + answerId
		$(elem).removeClass('hideAnswer')
		$(elem).addClass('showAnswer')

		isCorrectDiv = '#' + answerId + ' > div.correctAnswer'
		alert isCorrectDiv
		isCorrect = $(isCorrectDiv).text()
		if isCorrect is YES
			alert 'Horay!'
			correctAnswers = Session.get('correctAnswers') + 1
			Session.set('correctAnswers', correctAnswers)

