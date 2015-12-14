Template.changeQuestionTemplate.events
	'click .btnUpdateQuestion': (template) ->
		template.preventDefault

		showAnswerImgElem = $('input:radio[name=showAnswerImg]:checked')
		showAnswerElem = $('input:radio[name=showAnswerElem]:checked')
		correctAnswersElem = $('input:radio[name=correctAnswers]:checked')

		props = {
			title: $('#title').val()
			image: Session.get('questionImageId')
			showAnswerImg: $(showAnswerImgElem).val()
			showAnswer: $(showAnswerElem).val()
			showAnswerTimer: $('#showTimer').val()
			correctAnswers: $(correctAnswersElem).val()
			level: KID
			updatedDate: new Date()
		}

		Meteor.call 'changeQuestion', this._id, props, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'