Template.adultsGameTemplate.created = ->
	$('#btnPreviousQuestion').attr('disabled', 'disabled')
	Session.set('counter', 0)
	Session.set('correctAnswersCounter', 0)
	Session.set('wrongAnswersCounter', 0)
	Session.set('adultprogressvalue', 0)

	Deps.autorun ->
		Meteor.call 'getAdultQuestions', (error, result) ->
			if error
				alert 'Error'
			else
				Session.set('questions', result)

			$('#btnPreviousQuestion').attr('disabled', 'disabled')

Template.adultsGameTemplate.helpers
	numQuestions: ->
		Session.get('questions').length

	explanation: ->
		Session.get 'explanation'

	isRightAnswer: ->
		Session.get 'isRightAnswer'

	questionType: ->
		Session.get 'questionType'
		
	correctAnswers: ->
		console.log Session.get 'correctAnswersCounter'
		Session.get('correctAnswersCounter')

	getCountdown: ->
		Session.get('time')
		
	question:->
		if Session.get('counter') == 0
			$('#btnPreviousQuestion').attr('disabled', 'disabled')

		questions = Session.get('questions')
		question = questions[Session.get('counter')]

Template.adultsGameTemplate.events
	'click #btnPreviousQuestion':->
		i = Session.get('counter') - 1
		Session.set('counter', i)

		value = Session.get('adultprogressvalue') - 10
		Session.set('adultprogressvalue', value)
		$("#adultprogress-bar").css("width", value + "%").attr("aria-valuenow", value)

	'click .btnEndGame': ->
		$('#explanationModal').on('hidden.bs.modal').modal('hide')
		Router.go('/')
	
	'click #btnNextQuestion': ->
		i = Session.get('counter') + 1
		Session.set('counter', i)

		value = Session.get('adultprogressvalue') + 10
		Session.set('adultprogressvalue', value)
		$("#adultprogress-bar").css("width", value + "%").attr("aria-valuenow", value)

		if (Session.get('counter') > 0)
			$('#btnPreviousQuestion').removeAttr('disabled')
		
		if i >= Session.get('questions').length		
			props = {
				correctAnswers: Session.get('correctAnswersCounter')
				wrongAnswers: Session.get('wrongAnswersCounter')
				level: KID
				createdDate: new Date()
			}
			Meteor.call 'createStats', props, (err) ->
			Router.go('/')

	'click .btnAnswer': (event)->
		answerId = event.currentTarget.id
		elem = $('#explanation_' + answerId)
		elem.removeClass('hidden')
		Meteor.call 'countScores', (answerId), ->

