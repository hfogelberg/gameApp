$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

@answers = new Array()

Template.changeQuestionTemplate.rendered =->

Template.changeQuestionTemplate.helpers
	thumbRoot:->
		Session.get 'thumbRoot'

	questionImage: ->
		if Session.get 'questionImageId'
			return Session.get 'questionImageId'
		else
			return this.image
	
	complete: ->
		@status is "complete"

Template.changeQuestionTemplate.events
	'change input.file_bag': (e) ->
		$('.btnUpdateQuestion').attr('disabled', 'disabled')

		Cloudinary.upload e.currentTarget.files,
			folder: Meteor.settings.public.folder 
			(err,res) ->
				if err 
					alert err
					console.log err
				else
					Session.set('questionImageId', res.public_id)
					$('.btnUpdateQuestion').removeAttr('disabled')

	'click .deleteImage': (template) ->
		this.image =''
		Session.set('questionImageId', '')
		Cloudinary.delete this.image, (err,res) ->
			console.log "Cloudinary Error: #{err}"

	'click .btnUpdateQuestion': (template) ->
		template.preventDefault

		showAnswerImgElem = $('input:radio[name=showAnswerImg]:checked')
		showAnswerElem = $('input:radio[name=showAnswerElem]:checked')
		correctAnswersElem = $('input:radio[name=correctAnswers]:checked')
		questionTypeElem = $('input:radio[name=questionType]:checked')

		props = {
			title: $('#title').val()
			image: Session.get('questionImageId')
			showAnswerImg: $(showAnswerImgElem).val()
			showAnswer: $(showAnswerElem).val()
			questionType: $(questionTypeElem).val()
			showAnswerTimer: $('#showTimer').val()
			correctAnswers: $(correctAnswersElem).val()
			oneAnswerText: $('#oneAnswerText').val()
			level: KID
			updatedDate: new Date()
		}

		Meteor.call 'changeQuestion', this._id, props, (err) ->
			if err
				console.log err
			else
				Session.set('questionImageId', '')