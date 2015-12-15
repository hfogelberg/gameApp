clock = 0
timeLeft = ->
  if clock > 0
    clock--
    Session.set "time", clock
    # console.log clock
  else
    # console.log "That's All Folks"
    Meteor.clearInterval interval

interval = Meteor.setInterval(timeLeft, 1000)

Meteor.methods 
	'getQuestionParams': (res) ->
		console.log res
		Session.set('showAnswer', res.showAnswer)
		Session.set('showAnswerImg', res.showAnswerImg)
		Session.set('showAnswerTimer', res.showAnswerTimer)
		Session.set('correctAnswersParam', res.correctAnswers)

		if res.showAnswerTimer
			clock = res.showAnswerTimer
			interval = Meteor.setInterval(clock, 1000)

Template.kidsGameTemplate.rendered =->
	console.log 'rendered'
	$('ul.questionair li:first').removeClass('invisible')
	$('ul.questionair li:first').addClass('visible')
	Session.set('correctAnswers', 0)
	Session.set('nbrAskedQuestions', 0)
	Session.set('answerGiven', false)

	id = $('ul li.visible').attr('id')
	Meteor.call 'getOneQuestionById', id, (err, res) ->
		if err
			alert err
		else
			Meteor.call 'getQuestionParams', res, ->

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

		$('.btnAnswer').removeAttr('disabled')
		elem = $('ul.questionair li.visible')
		elem.removeClass('visible')
		elem.addClass('invisible')
		elem.addClass('noHeight')
		
		elem.next().removeClass('invisible')
		elem.next().addClass('visible')

		elem = $('ul li.visible .questionProps .showAnswerTimer')

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
