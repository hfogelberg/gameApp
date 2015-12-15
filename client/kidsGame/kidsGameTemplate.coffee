countdown = new ReactiveCountdown(
	5,
	completed: ->
		Meteor.call 'timerComplete', ->
)

Meteor.methods 'timerComplete': ->
  console.log 'Timer complete'

Template.kidsGameTemplate.rendered =->
	console.log 'rendered'
	$('ul.questionair li:first').removeClass('invisible')
	$('ul.questionair li:first').addClass('visible')
	Session.set('correctAnswers', 0)
	Session.set('nbrAskedQuestions', 0)
	Session.set('answerGiven', false)

	# elem = $('.visible.questionPropsshowAnswerTimer')
	# timer = elem.text()
	# alert timer

	# countdown.add(timer)
	countdown.start()


Template.kidsGameTemplate.helpers
	getCountdown:->
		return countdown.get()

	answerGiven:->
		Session.get 'answerGiven'

	correctAnswers:->
		Session.get 'correctAnswers'

Template.kidsGameTemplate.events
	'click #btnNextQuestion': (event) ->
		event.preventDefault

		$('.btnAnswer').removeAttr('disabled')
		elem = $('ul.questionair li.visible').addClass('visible')
		elem.removeClass('visible')
		elem.addClass('invisible')
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
			correctAnswers = Session.get('correctAnswers') + 1
			Session.set('correctAnswers', correctAnswers)
		else
			console.log 'Ouch. Wrong'

		nbrAskedQuestions = Session.get('nbrAskedQuestions') + 1
		Session.set('nbrAskedQuestions', nbrAskedQuestions)
