clock = 0
timeLeft = ->
  if clock > 0
    clock--
    Session.set "time", clock
    # console.log clock
  else
    Meteor.clearInterval interval
    if Session.get('showAnswer')
    	elem = $('.answerTitle')
			elem.removeClass('invisible')

		if Session.get('correctAnswersParam') is 'ONE'
			str = '.btnAnswer:not("#' + Session.get('correctAnswerId') + '")'
			$(str).addClass('invisible')
			$('.oneAnswerText').removeClass('invisible')


interval = Meteor.setInterval(timeLeft, 1000)

Meteor.methods 
	'getQuestionParams': (res) ->
		console.log res
		Session.set('showAnswer', res.showAnswer)
		Session.set('showAnswerImg', res.showAnswerImg)
		Session.set('questionType', res.questionType)
		Session.set('showAnswerTimer', res.showAnswerTimer)
		Session.set('correctAnswersParam', res.correctAnswers)

		for answer in res.answers 
			if answer.isCorrectAnswer is YES
				console.log 'Correct Answer: ' + answer.answerId
				Session.set('correctAnswerId', answer.answerId)

		if res.showAnswer
			elem = $('.answerTitle')
			elem.addClass('invisible')

Template.kidsGameTemplate.rendered =->
	console.log 'rendered'
	$('ul.questionair li:first').removeClass('invisible')
	$('ul.questionair li:first').addClass('visible')
	Session.set('correctAnswers', 0)
	Session.set('nbrAskedQuestions', 0)
	Session.set('answerGiven', false)

	$('.answerTitle').removeClass('invisible')
	$('.oneAnswerText').addClass('invisible')

	id = $('ul li.visible').attr('id')
	Meteor.call 'getOneQuestionById', id, (err, res) ->
		Meteor.call 'getQuestionParams', res, ->
		if Session.get('showAnswerTimer')
			console.log 'starting timer with interva ' + res.showAnswerTimer
			clock = res.showAnswerTimer
			interval = Meteor.setInterval(clock, 1000)

Template.kidsGameTemplate.helpers
	getCountdown:->
		Session.get 'time'

	answerGiven:->
		Session.get 'answerGiven'

	correctAnswers:->
		Session.get 'correctAnswers'

Template.kidsGameTemplate.events
	'click #btnNextQuestion': (event) ->
		event.preventDefault

		Meteor.clearInterval interval

		$('.btnAnswer').removeAttr('disabled')
		elem = $('ul.questionair li.visible')
		elem.removeClass('visible')
		elem.addClass('invisible')
		elem.addClass('noHeight')
		
		elem.next().removeClass('invisible')
		elem.next().addClass('visible')

		id = $('ul li.visible').attr('id')
		console.log 'Next question id: ' + id
		Meteor.call 'getOneQuestionById', id, (err, res) ->
			Meteor.call 'getQuestionParams', res, ->

			if Session.get('showAnswerTimer')
				console.log 'starting timer with interval ' + res.showAnswerTimer
				clock = res.showAnswerTimer
				interval = Meteor.setInterval(clock, 1000)

	'click .btnAnswer': (event) ->
		event.preventDefault

		Meteor.clearInterval interval
		
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

		console.log 'Number of asked questions ' + nbrAskedQuestions
		if parseInt(nbrAskedQuestions) == NUM_ADULT_QUESTIONS
			console.log 'Redirect'

			props = {
				correctAnswers: Session.get('correctAnswers')
				level: KID
				createdDate: new Date()
			}

			Meteor.call 'createStats', props, (err) ->
			Router.go('/')
