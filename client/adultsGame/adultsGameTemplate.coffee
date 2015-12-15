Template.adultsGameTemplate.rendered =->
	console.log 'rendered'
	$('ul.questionair li:first').removeClass('invisible')
	$('ul.questionair li:first').addClass('visible')
	Session.set('correctAnswers', 0)
	Session.set('nbrAskedQuestions', 0)
	Session.set('answerGiven', false)

Template.adultsGameTemplate.helpers
	answerGiven:->
		Session.get 'answerGiven'

	correctAnswers:->
		Session.get 'correctAnswers'

Template.adultsGameTemplate.events
	'click #btnNextQuestion': (event) ->
		event.preventDefault

		$('.btnAnswer').removeAttr('disabled')
		elem = $('ul.questionair li.visible')
		elem.removeClass('visible')
		elem.addClass('invisible')
		elem.addClass('noHeight')
		
		elem.next().removeClass('invisible')
		elem.next().addClass('visible')

	'click .btnAnswer': (event) ->
		event.preventDefault

		$('.btnAnswer').attr('disabled', 'disabled')

		answerId = event.currentTarget.id

		console.log  'Selected answer: ' + answerId
		elem = '.' + answerId + '.comment'
		$(elem).removeClass('hideAnswer')
		$(elem).addClass('showAnswer')

		isCorrectDiv = '.' + answerId + '.correctAnswer'
		isCorrect = $(isCorrectDiv).text()

		if isCorrect is YES
			console.log 'Horay!'
			correctAnswers = Session.get('correctAnswers')
			correctAnswers = correctAnswers + 1
			Session.set('correctAnswers', correctAnswers)
		else
			console.log 'Ouch. Wrong'

		nbrAskedQuestions = Session.get('nbrAskedQuestions') + 1
		Session.set('nbrAskedQuestions', nbrAskedQuestions)

		console.log 'Number of asked questions ' + nbrAskedQuestions
		if parseInt(nbrAskedQuestions) == NUM_ADULT_QUESTIONS
			console.log 'Redirect'

			props = {
				correctAnswers: Session.get('correctAnswers')
				level: kid
				createdDate: new Date()
			}

			Meteor.call 'createStats', props, (err) ->
			
			Router.go('/')

			Router.go('/')



