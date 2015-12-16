Template.adultsGameTemplate.created = ->
	Session.set('counter', 0)
	Session.set('correctAnswersCounter', 0)

	Deps.autorun ->
		Meteor.call 'getAdultQuestions', (error, result) ->
			if error
				alert 'Error'
			else
				Session.set('questions', result)

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
		questions = Session.get('questions')
		question = questions[Session.get('counter')]

Template.adultsGameTemplate.events
	'click .btnEndGame': ->
		$('.modal').modal('hide')
		$('body').removeClass('modal');
		$('.modal-backdrop').remove();
		Router.go('/')

	'click #btnNextQuestion': ->
		i = Session.get('counter') + 1
		Session.set('counter', i)

		if i >= Session.get('questions').length		
			$('body').on 'hidden.bs.modal', '.modal', ->
			  $(this).removeData 'bs.modal'
			Router.go('/thanks')
			# $('#thankYouModal').modal('show')

	'click .btnAnswer': (event)->
		console.log 'btnAnswer'
		answerId = event.currentTarget.id
		elem = $('#explanation_' + answerId)
		elem.removeClass('hidden')
		Meteor.call 'countScores', (answerId), ->

