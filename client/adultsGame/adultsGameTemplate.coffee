Template.adultsGameTemplate.rendered =->
	console.log 'rendered'
	$('ul.questionair li:first').removeClass('invisible')
	$('ul.questionair li:first').addClass('visible')
	Session.set('correctAnswers', 0)
	Session.set('nbrAskedQuestions', 0)

Template.adultsGameTemplate.helpers
	correctAnswers:->
		Session.get 'correctAnswers'
	nbrAskedQuestions:->
		Session.get 'nbrAskedQuestions'

Template.adultsGameTemplate.events
	'click #btnNextQuestion': (event) ->
		event.preventDefault

		elem = $('ul.questionair li.visible').addClass('visible')
		elem.removeClass('visible')
		elem.addClass('invisible')
		elem.next().removeClass('invisible')
		elem.next().addClass('visible')

	'click .btnAnswer': (event) ->
		event.preventDefault

		answerId = event.currentTarget.id

		console.log  'Selected answer: ' + answerId
		elem = '.explanation#' + answerId
		$(elem).removeClass('hideAnswer')
		$(elem).addClass('showAnswer')

		isCorrectDiv = '#' + answerId + ' > div.correctAnswer'
		isCorrect = $(isCorrectDiv).text()
		if isCorrect is YES
			console.log 'Horay!'
			correctAnswers = Session.get('correctAnswers') + 1
			Session.set('correctAnswers', correctAnswers)
		else
			console.log 'Ouch. Wrong'

		nbrAskedQuestions = Session.get('nbrAskedQuestions') + 1
		Session.set('nbrAskedQuestions', nbrAskedQuestions)

